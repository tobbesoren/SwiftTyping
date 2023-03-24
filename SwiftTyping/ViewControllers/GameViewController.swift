//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentWord: String?
    var clock: Clock?
    var difficulty: Int = 3
    let gameWords = GameWords(difficulty: 3)
    var score = 0
   

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        clock = Clock(clockTickFunction: updateTimerLabel, timesUp: timesUp)
        setNewRandomWord()
        difficultyLabel.text = String(gameWords.getDifficulty())
        clock?.startTimer(difficulty: gameWords.getDifficulty(), wordLength: randomWordLabel.text?.count ?? difficulty)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        setNewRandomWord()
        clock?.startTimer(difficulty: gameWords.getDifficulty(), wordLength: randomWordLabel.text?.count ?? difficulty)
    }
    
    func setNewRandomWord() {
        currentWord = gameWords.getRandomWord()
        randomWordLabel.text = currentWord
    }
    
    func timesUp() {
        timerLabel.text = "Time's up!"
    }
    
    func updateTimerLabel() {
        let currentTime = String(Int(Double(clock!.timeLeft) - Double(clock!.timeSpent)))
        timerLabel.text = currentTime
    }
    
    func updateScoreLabel() {
        
    }
    
    @IBAction func textEdited(_ sender: Any) {
        if editTextField.text == currentWord {
            print("Correct!")
            setNewRandomWord()
            clock?.startTimer(difficulty: gameWords.getDifficulty(), wordLength: randomWordLabel.text?.count ?? difficulty)
            editTextField.text = ""
            score += 1
            scoreLabel.text = String(score)
        }
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
