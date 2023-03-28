//
//  Game.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation


class Game {
    let defaults = UserDefaults.standard
    
    let gameWords: GameWords
    var clock: Clock?
    
    let scoreFunction: (Int) -> Void
    let randomWordFunction: (String) -> Void
    let levelFunction: (Int) -> Void
    let clockTickFunction: () -> Void
    let timesUpFunction: () -> Void
    
    var score = 0
    var level: Int = 3
    var currentWord: String = ""
    var difficulty: Int = 1
    var startLevel = 3
    var clearedWords = 0
    var gameRunning = false
    
    var enteredWord = ""
    

    init(scoreFunction: @escaping (Int) -> Void,
         randomWordFunction: @escaping (String) -> Void,
         levelFunction: @escaping (Int) -> Void,
         clockTickFunction: @escaping () -> Void,
         timesUpFunction: @escaping () -> Void ) {
        self.scoreFunction = scoreFunction
        self.randomWordFunction = randomWordFunction
        self.levelFunction = levelFunction
        self.clockTickFunction = clockTickFunction
        self.timesUpFunction = timesUpFunction
        self.difficulty = defaults.integer(forKey: "Difficulty") + 1
        self.level = defaults.integer(forKey: "StartLevel") + 3
        gameWords = GameWords(level: level)
    }
    
    func startGame() {
        gameRunning = true
        clock = Clock(clockTickFunction: clockTickFunction, timesUpFunction: gameOver)
        newWord()
    }
    
    func newWord() {
        currentWord = gameWords.getRandomWord()
        clock?.startTimer(timeSet: calculateTime())
        randomWordFunction(currentWord)
    }
    
    func setEnteredWord(word: String) {
        enteredWord = word
    }
    
    func setDifficulty(difficulty: Int) {
        self.difficulty = difficulty
    }
    
    func getDifficulty() -> Int {
        return difficulty
    }
    
    func raiseLevel() {
       
        if level < 27 {
            level += 1
            gameWords.setLevel(level: level)
            levelFunction(level)
        }
    }
    
    func decreaseLevel() {
        if level > 3 {
            level -= 1
            gameWords.setLevel(level: level)
            levelFunction(level)
        }
    }
    
    func getLevel() -> Int {
        return level
    }
    
    func updateScore() {
        let newScore = difficulty * currentWord.count * (Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0))
        score += newScore
//        print("level:", level, "difficulty:", difficulty, "wordLength:", String(currentWord.count), "time:",  String(Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0)))
//        print(newScore)
        scoreFunction(score)
    }
    
    
    func setCurrentWord() {
        currentWord = gameWords.getRandomWord()
    }
    
    func checkWord() -> Bool{
        //print(enteredWord)
        if enteredWord == currentWord {
            clearedWords += 1
            updateScore()
            checkForLevelUp()
            newWord()
            return true
        }
        return false
    }
    
    func checkForLevelUp() {
        if clearedWords % 10 == 0 {
            raiseLevel()
        }
    }
    
    func gameOver() {
        timesUpFunction()
    }
    
    func resetValues() {
        score = 0
        level = 3
        currentWord = ""
        difficulty = 1
        clearedWords = 0
        gameRunning = false
        
    }
    
    
    
    func startClock() {
        clock?.startTimer(timeSet: calculateTime())
    }
    
    func calculateTime() -> Double {
        let secondsPerLetter = (1.0 - (Double(level) / 100))  * (0.7 - Double(difficulty) / 10)
        let timeLeft = (Double(currentWord.count) * secondsPerLetter) + 2
        print(String(secondsPerLetter))
        return timeLeft
    }
    
    
}
