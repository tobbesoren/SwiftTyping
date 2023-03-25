//
//  GameWords.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation

class GameWords {
    
    private var wordDict: [Int: [String]] = [:]
    private var level: Int
    private var currentWordList = [String]()
    
    init(level: Int) {
        self.level = level
        let filePath = Bundle.main.path(forResource: "svenska-ord", ofType: "txt");
            let URL = NSURL.fileURL(withPath: filePath!)

            do {
                let string = try String.init(contentsOf: URL)
                for line in string.components(separatedBy: "\n") {
                    if line.count > 2 && line.prefix(1) != "-" && line.suffix(1) != "-"{
                        addWordToDict(word: line)
                    }
                }
            } catch  {
                print(error);
            }
        setCurrentWordList()
        print(currentWordList)
    }
    
    private func addWordToDict(word: String) {
        let key = word.count
        if wordDict[key] != nil {
            wordDict[key]?.append(word)
        } else {
            wordDict[key] = [word]
        }
    }
    
    private func setCurrentWordList() {
        var wordList = [String]()
        let maxWordLength = level + 3
        for key in level...maxWordLength {
            if let newList = wordDict[key] {
                wordList += newList
            }
        }
        currentWordList = wordList
    }
    
    func setLevel(level: Int) {
        self.level = level
        setCurrentWordList()
    }
    
    func getLevel() -> Int {
        return level
    }

    func getRandomWord() -> String {
        return currentWordList.randomElement() ?? "Empty word list"
    }
}
