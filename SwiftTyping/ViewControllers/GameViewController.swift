//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    //    var currentWord: String = ""
    //    //var clock: Clock?
    //    var level: Int = 3
    //    var difficulty = 1
    //    let gameWords = GameWords(level: 3)
    //    var score = 0
    var game: Game?
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(scoreFunction: updateScoreLabel, randomWordFunction: updateWordLabel, levelFunction: updateLevelLabel, clockTickFunction: updateTimerLabel, timesUpFunction: timesUp)
        
        levelLabel.text = String(game?.gameWords.getLevel() ?? 0)
        scoreLabel.text = String(game?.score ?? 0)
        
        //        clock = Clock(clockTickFunction: updateTimerLabel, timesUpFunction: timesUp)
        //        setNewRandomWord()
        
        //        clock?.startTimer(timeSet: calculateTime())
        //        // Do any additional setup after loading the view.
    }
    
    
    
    
    //    func setNewRandomWord() {
    //        currentWord = gameWords.getRandomWord()
    //        randomWordLabel.text = currentWord
    //    }
    
    
    func updateScoreLabel(score: Int) {
        scoreLabel.text = String(score)
        //        let newScore = level * difficulty * currentWord.count * (Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0))
        //        score += newScore
        //        scoreLabel.text = String(score)
    }
    
    func updateWordLabel(word: String) {
        randomWordLabel.text = word
    }
    
    func updateLevelLabel(level: Int) {
        levelLabel.text = String(level)
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
    //        setNewRandomWord()
    //        clock?.startTimer(timeSet: calculateTime())
    
    @IBAction func textFieldSelected(_ sender: Any) {
        print("!!!")
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
        
        //        if editTextField.text == currentWord {
        //            updateScoreLabel()
        //            setNewRandomWord()
        //            clock?.startTimer(timeSet: calculateTime())
        //            editTextField.text = ""
        //        }
    }
    
    //    func calculateTime() -> Double {
    //        let secondsPerLetter = (1.0 - (Double(level) / 100))  * 0.6
    //        let timeLeft = (Double(currentWord.count) * secondsPerLetter) + 2
    //        return timeLeft
    //    }
    
    
    @IBAction func diffDownPressed(_ sender: Any) {
        game?.decreaseLevel()
        //        let level = gameWords.getLevel()
        //        if level > 3 {
        //            gameWords.setLevel(level: level - 1)
        //            levelLabel.text = String(gameWords.getLevel())
        //        }
    }
    
    
    @IBAction func diffUpPressed(_ sender: Any) {
        game?.raiseLevel()
        //        let level = gameWords.getLevel()
        //        if level < 27  {
        //            gameWords.setLevel(level: level + 1)
        //            levelLabel.text = String(gameWords.getLevel())
        //        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameOverSegue" {
            if let destinationVC = segue.destination as? GameOverViewController {
               destinationVC.score = game?.score
            }
            
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
