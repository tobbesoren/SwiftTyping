//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    var game: Game?
   
    let defaults = DefaultsHandler()
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(scoreFunction: updateScoreLabel,
                    randomWordFunction: updateWordLabel,
                    levelFunction: updateLevelLabel,
                    clockTickFunction: updateTimerLabel,
                    timesUpFunction: timesUp)
        
        editTextField.spellCheckingType = .no
        editTextField.autocorrectionType = .no
        
        resetLabels()
    }
    
    func setDifficultyLabel() -> String {
        switch defaults.getDifficulty() {
        case 1: return "Easy"
        case 2: return "Normal"
        case 3: return "Hard"
        default: return ""
        }
        
    }
    
    func resetLabels() {
        nameLabel.text = defaults.getName()
        updateLevelLabel(level: defaults.getLevel())
        updateScoreLabel(score: 0)
        difficultyLabel.text = setDifficultyLabel()
        timerLabel.text = "0"
        randomWordLabel.text = "Ready?"
        editTextField.text = ""
        editTextField.placeholder = "Tap to start"
    }
    
    func updateScoreLabel(score: Int) {
        scoreLabel.text = "Score: \(String(score))"
    }
    
    func updateWordLabel(word: String) {
        randomWordLabel.text = word
    }
    
    func updateLevelLabel(level: Int) {
        levelLabel.text = "Level: \(String(level))"
    }
    
    func updateTimerLabel() {
        let currentTime = String(Int(Double(game?.clock!.timeLeft ?? 0) - Double(game?.clock!.timeSpent ?? 0)))
        timerLabel.text = currentTime
    }
    
    func timesUp() {
        performSegue(withIdentifier: "GameOverSegue", sender: nil)
        game?.resetValues()
        resetLabels()
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
