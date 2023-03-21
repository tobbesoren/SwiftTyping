//
//  Game.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation
import UIKit

class Game {
    private let gameWords = GameWords()
    private var clock: Clock
    
    init(timerLabel: UILabel!, difficulty: Int) {
        gameWords.setDifficulty(difficulty: difficulty)
        self.clock = Clock(secondsLeft: 5, timerLabel: timerLabel)
    }
}
