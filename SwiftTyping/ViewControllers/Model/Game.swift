//
//  Game.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation


class Game {
    let gameWords: GameWords
    let clock: Clock
    
    let clockTickFunction: () -> Void
    let timesUpFunction: () -> Void
    
    var score = 0
    var level: Int = 3
    var currentWord: String = ""
    var difficulty: Int = 1
    

    init(clockTickFunction: @escaping () -> Void, timesUpFunction: @escaping () -> Void ) {
        self.clockTickFunction = clockTickFunction
        self.timesUpFunction = timesUpFunction
        gameWords = GameWords(level: level)
        clock = Clock(clockTickFunction: clockTickFunction, timesUpFunction: timesUpFunction)
    }
    
    func startGame() {
        
    }
    
    func setDifficulty(difficulty: Int) {
        self.difficulty = difficulty
    }
    
    func getDifficulty() -> Int {
        return difficulty
    }
    
    func raiseLevel() {
        if level <= 27 {
            level += 1
        }
    }
    
    func getLevel() -> Int {
        return level
    }
    
    func updateScore() {
        // Yeah, this should be updated
        let newScore = level * difficulty * currentWord.count * Int(clock.timeLeft)
        score += newScore
    }
    
    
    func setCurrentWord() {
        currentWord = gameWords.getRandomWord()
    }
    
    func checkWord(word: String) -> Bool {
        return word == currentWord
    }
    
    func timesUp() {
        
    }
    
    func startClock() {
        clock.startTimer(timeSet: calculateTime())
    }
    
    func calculateTime() -> Double {
        let secondsPerLetter = (1.0 - (Double(level) / 100))  * 0.6
        let timeLeft = (Double(currentWord.count) * secondsPerLetter) + 2
        return timeLeft
    }
    
    
}
