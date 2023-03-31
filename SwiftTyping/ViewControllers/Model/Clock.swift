//
//  Clock.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation

/*
 This class is used by Game to add a timer. Takes two functions as arguments.
 The first determines what happens at every clocktick (Eg. update timer view)
 The second determines what happens once tmie is up.
 */

class Clock {
    var timeLeft : Double = 0.0
    var startTime : Date?
    var timer : Timer?
    var timeSpent : Double
    var isRunning : Bool
    var clockTickFunction : () -> Void
    var timesUpFunction : () -> Void
    
    init(clockTickFunction: @escaping () -> Void, timesUpFunction: @escaping () -> Void) {
        
        self.timer = Timer()
        self.isRunning = false
        self.timeSpent = 0.0
        self.clockTickFunction = clockTickFunction
        self.timesUpFunction = timesUpFunction
    }
    
    
    func startTimer(timeSet: Double) {
        timeLeft = timeSet
        setStartTime()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: runTimer(timer:))
        isRunning = true
        }
    
    
    func setStartTime() {
        startTime = Date()
    }
    
    
    func runTimer(timer : Timer) {
        if !isRunning {return}
        if let startTime {
            timeSpent = Date().timeIntervalSince1970 - startTime.timeIntervalSince1970
        } else {return}
        
        if timeLeft - timeSpent  > 1 {
            clockTickFunction()
        } else {
            self.timeLeft = 0.0
            self.timeSpent = 0.0
            timer.invalidate()
            isRunning = false
            timesUpFunction()
        }
    }
    
    
    
    func stopTimer() {
        timeLeft -= timeSpent
        isRunning = false
        timer?.invalidate()
    }
}

