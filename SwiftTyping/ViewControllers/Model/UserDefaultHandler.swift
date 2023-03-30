//
//  UserDefaultHandler.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-30.
//

import Foundation


class defaultsHandler {
    private let defaults = UserDefaults.standard
    private var name: String
    private var difficulty: Int
    private var level: Int
    private var hiScores: [[String]]
    
    init() {
        self.name = defaults.object(forKey: "PlayerName") as? String ?? "Incognito"
        self.difficulty = defaults.integer(forKey: "Difficulty")
        self.level = defaults.integer(forKey: "StartLevel")
        self.hiScores = defaults.object(forKey: "HiScores") as? [[String]] ?? [[String]]()
    }
    
    func setName() {
        
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setDifficulty() {
        
    }
    
    func getDifficulty() -> Int {
        return self.difficulty
    }
    
    func setLevel() {
        
    }
    
    func getLevel() -> Int {
        return self.level
    }
    
    func sddHiScore() {
        
    }
    
    func getHiScores() -> [[String]] {
        return self.hiScores
    }
}
