//
//  Game.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation


class Game {
    let defaults = DefaultsHandler()
    let gameWords: GameWords
    var clock: Clock?
    
    let scoreFunction: (Int) -> Void
    let randomWordFunction: (String) -> Void
    let levelFunction: (Int) -> Void
    let clockTickFunction: () -> Void
    let timesUpFunction: () -> Void
    
    var score = 0
    var level: Int = 1
    var currentWord: String = ""
    var difficulty: Int = 1
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
        self.difficulty = defaults.getDifficulty()
        self.level = defaults.getLevel()
        
        gameWords = GameWords(level: level)
        clock = Clock(clockTickFunction: clockTickFunction, timesUpFunction: gameOver)
    }
    
    func startGame() {
        gameRunning = true
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
    
    func raiseLevel() {
       if level < 25 {
            level += 1
            gameWords.setWordLength(level: level)
            levelFunction(level)
        }
    }
    
    func decreaseLevel() {
        if level > 1 {
            level -= 1
            gameWords.setWordLength(level: level)
            levelFunction(level)
        }
    }
    
    func updateScore() {
        let newScore = difficulty * currentWord.count * (Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0))
        score += newScore
        scoreFunction(score)
    }
    
    func checkWord() -> Bool{
       
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
        level = defaults.getLevel()
        print(String(defaults.getLevel()))
        currentWord = ""
        difficulty = defaults.getDifficulty()
        clearedWords = 0
        gameRunning = false
        gameWords.setWordLength(level: level)
    }
    
    
    func calculateTime() -> Double {
        let secondsPerLetter = (1.0 - (Double(level) / 50))  * (0.7 - Double(difficulty) / 8)
        let timeLeft = (Double(currentWord.count) * secondsPerLetter) + 2
        print(String(secondsPerLetter))
        return timeLeft
    }
    
    
}
