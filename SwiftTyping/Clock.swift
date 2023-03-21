//
//  Clock.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation
import UIKit

class Clock {
    var timeLeft : Double = 0
    var startTime : Date?
    var timer : Timer?
    var timeSpent : Double
    var isRunning : Bool
    var timerLabel : UILabel!
    
    init(secondsLeft: Double, timerLabel: UILabel!) {
        self.timeLeft = secondsLeft
        self.timer = Timer()
        self.isRunning = false
        self.timeSpent = 0
        self.timerLabel = timerLabel
    }
    
    
    func startTimer() {
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
            timerLabel.text = String(Int(timeLeft - timeSpent))
        } else {
            timesUp()
        }
    }
    
    func timesUp() {
        timerLabel.text = "Time's up!"
    }
    
    
    func stopTimer() {
        timeLeft -= timeSpent
        isRunning = false
        timer?.invalidate()
    }
}

