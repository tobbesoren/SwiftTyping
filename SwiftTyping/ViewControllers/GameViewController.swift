//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    var game: Game?
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name: String = defaults.object(forKey: "PlayerName") as? String {
            print(name)
            nameLabel.text = name
        }
        
        
        game = Game(scoreFunction: updateScoreLabel, randomWordFunction: updateWordLabel, levelFunction: updateLevelLabel, clockTickFunction: updateTimerLabel, timesUpFunction: timesUp)
        
        levelLabel.text = "Level: \(String(((game?.gameWords.getLevel() ?? 0) - 2) ))"
        scoreLabel.text = String(game?.score ?? 0)
    }
    
    func updateScoreLabel(score: Int) {
        scoreLabel.text = String(score)
    }
    
    func updateWordLabel(word: String) {
        randomWordLabel.text = word
    }
    
    func updateLevelLabel(level: Int) {
        levelLabel.text = "Level: \(String(level - 2))"
    }
    
    func updateTimerLabel() {
        let currentTime = String(Int(Double(game?.clock!.timeLeft ?? 0) - Double(game?.clock!.timeSpent ?? 0)))
        timerLabel.text = currentTime
    }
    
    func timesUp() {
        performSegue(withIdentifier: "GameOverSegue", sender: nil)
        game?.resetValues()
        randomWordLabel.text = "Ready?"
        scoreLabel.text = "Score"
        timerLabel.text = "0"
        levelLabel.text = String(game?.gameWords.getLevel() ?? 0)
        scoreLabel.text = String(game?.score ?? 0)
        editTextField.text = ""
        
    }
    
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        game?.newWord()
    }
    
    @IBAction func textFieldSelected(_ sender: Any) {
        editTextField.placeholder = ""
        
        
        if let gameRunning = game?.gameRunning {
            if !gameRunning {
                game?.startGame()
            }
        }
    }
    
    @IBAction func textEdited(_ sender: Any) {
        
        game?.enteredWord = editTextField.text ?? ""
        if let game {
            if game.checkWord() {editTextField.text = ""}
        }
    }
    
    @IBAction func diffDownPressed(_ sender: Any) {
        game?.decreaseLevel()
    }
    
    
    @IBAction func diffUpPressed(_ sender: Any) {
        game?.raiseLevel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameOverSegue" {
            if let destinationVC = segue.destination as? GameOverViewController {
               destinationVC.score = game?.score
            }
        }
    }
}
