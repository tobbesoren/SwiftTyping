//
//  UserDefaultHandler.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-30.
//

import Foundation

/*
 This class handles read and write from/to userDefaults.
 */
class DefaultsHandler {
    private let defaults = UserDefaults.standard
    private var name: String
    private var difficulty: Int
    private var level: Int
    private var hiScores: [[String]]
    
    let nameString = "PlayerName"
    let difficultyString = "Difficulty"
    let levelString = "StartLevel"
    let HiScoreString = "HiScores"
    
    init() {
        self.name = defaults.object(forKey: nameString) as? String ?? "Incognito"
        self.difficulty = defaults.integer(forKey: difficultyString)
        self.level = defaults.integer(forKey: levelString)
        self.hiScores = defaults.object(forKey: HiScoreString) as? [[String]] ?? [[String]]()
    }
    
    func updateDefaults() {
        self.name = defaults.object(forKey: nameString) as? String ?? "Incognito"
        self.difficulty = defaults.integer(forKey: difficultyString)
        self.level = defaults.integer(forKey: levelString)
        self.hiScores = defaults.object(forKey: HiScoreString) as? [[String]] ?? [[String]]()
    }
    
    func setName(name: String) {
        self.name = name
        self.defaults.set(name, forKey: nameString)
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setDifficulty(difficulty: Int) {
        self.difficulty = difficulty
        self.defaults.set(difficulty, forKey: difficultyString)
   
    }
    
    func getDifficulty() -> Int {
        return self.difficulty
    }
    
    func setLevel(level: Int) {
        self.level = level
        self.defaults.set(level, forKey: levelString)
    }
    
    func getLevel() -> Int {
        return self.level
    }
    
    func addHiScore(newScore: [String]) {
        self.hiScores.append(newScore)
        self.hiScores.sort(by: {Int($0[0] ) ?? 0 > Int($1[0] ) ?? 0})
        self.defaults.set(self.hiScores, forKey: HiScoreString)
    }
    
    func getHiScores() -> [[String]] {
        return self.hiScores
    }
    
    func getDifficultyString() -> String {
        switch self.difficulty {
        case 1: return "Easy"
        case 2: return "Normal"
        case 3: return "Hard"
        default: return ""
        }
    }
}
