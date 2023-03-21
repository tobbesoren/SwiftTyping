//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    let gameWords = GameWords()
    var currentWord: String?
    var clock: Clock?
   

    @IBOutlet weak var randomWordLabel: UILabel!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clock = Clock(secondsLeft: 10.0, timerLabel: timerLabel)
        setNewRandomWord()
        difficultyLabel.text = String(gameWords.getDifficulty())
        clock?.startTimer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        setNewRandomWord()
    }
    
    func setNewRandomWord() {
        currentWord = gameWords.getRandomWord()
        randomWordLabel.text = currentWord
    }
    
    @IBAction func diffDownPressed(_ sender: Any) {
        let difficulty = gameWords.getDifficulty()
        if difficulty > 3 {
            gameWords.setDifficulty(difficulty: difficulty - 1)
            difficultyLabel.text = String(gameWords.getDifficulty())
        }
    }
    
    
    @IBAction func diffUpPressed(_ sender: Any) {
        let difficulty = gameWords.getDifficulty()
        if difficulty < 27  {
            gameWords.setDifficulty(difficulty: difficulty + 1)
            difficultyLabel.text = String(gameWords.getDifficulty())
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
