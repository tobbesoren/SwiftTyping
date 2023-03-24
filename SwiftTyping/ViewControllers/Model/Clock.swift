//
//  Clock.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation

class Clock {
    var timeLeft : Double = 0
    var startTime : Date?
    var timer : Timer?
    var timeSpent : Double
    var isRunning : Bool
    var clockTickFunction : () -> Void
    var timesUp : () -> Void
    
    init(clockTickFunction: @escaping () -> Void, timesUp: @escaping () -> Void) {
        
        self.timer = Timer()
        self.isRunning = false
        self.timeSpent = 0
        self.clockTickFunction = clockTickFunction
        self.timesUp = timesUp
    }
    
    
    func startTimer(difficulty: Int, wordLength: Int) {
        let secondsPerLetter = (1.0 - (Double(difficulty) / 100))  * 0.6
        timeLeft = (Double(wordLength) *  secondsPerLetter) + 2
        print(wordLength, difficulty, secondsPerLetter, timeLeft)
        setStartTime()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: runTimer(timer:))
        isRunning = true
        }
    
    
    func setStartTime() {
        startTime = Date()
    }
    
    
    func runTimer(timer : Timer) {
        if let startTime {
            timeSpent = Date().timeIntervalSince1970 - startTime.timeIntervalSince1970
        } else {return}
        
        if timeLeft - timeSpent  > 1 {
            clockTickFunction()
        } else {
            timesUp()
        }
    }
    
    
    
    func stopTimer() {
        timeLeft -= timeSpent
        isRunning = false
        timer?.invalidate()
    }
}

