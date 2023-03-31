//
//  GameWords.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import Foundation

/*
 This class handles word list.
 It reads the words from a .txt-file and adds them to a dictionary, where
 word length is used as keys. So the dictionary holds a number of arrays of strings:
 One for three-letter words, one for four-letter words and so on.
 It also keeps track of current wordLength, based on level, and a currentWordList
 built from the dictionary, using wordLength to determin which arrays to use.
 It can return a random word from currentWordList.
 */
class GameWords {
    
    private var wordDict: [Int: [String]] = [:]
    private var wordLength: Int
    private var currentWordList = [String]()
    
    init(level: Int) {
        self.wordLength = level + 2
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
        let maxWordLength = wordLength + 3
        for key in wordLength...maxWordLength {
            if let newList = wordDict[key] {
                wordList += newList
            }
        }
        currentWordList = wordList
    }
    
    func setWordLength(level: Int) {
        self.wordLength = level + 2
        setCurrentWordList()
    }

    func getRandomWord() -> String {
        return currentWordList.randomElement() ?? "Empty word list"
    }
}
