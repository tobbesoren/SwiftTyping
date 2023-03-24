//
//  GameViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentWord: String = ""
    var clock: Clock?
    var level: Int = 3
    var difficulty = 1
    let gameWords = GameWords(level: 3)
    var score = 0
    var game: Game?
   

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(clockTickFunction: updateTimerLabel, timesUpFunction: timesUp)
        scoreLabel.text = String(score)
        clock = Clock(clockTickFunction: updateTimerLabel, timesUpFunction: timesUp)
        setNewRandomWord()
        levelLabel.text = String(gameWords.getLevel())
        clock?.startTimer(timeSet: calculateTime())
        // Do any additional setup after loading the view.
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        setNewRandomWord()
        clock?.startTimer(timeSet: calculateTime())
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
        print("level: \(level) * difficulty: \(difficulty) * wordLength: \(currentWord.count)  * timeLeft: \(Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0)) Score: \(level * difficulty * currentWord.count * (Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0)))" )
        let newScore = level * difficulty * currentWord.count * (Int(clock?.timeLeft ?? 0) - Int(clock?.timeSpent ?? 0))
        score += newScore
        scoreLabel.text = String(score)
    }
    
    @IBAction func textEdited(_ sender: Any) {
        if editTextField.text == currentWord {
            updateScoreLabel()
            setNewRandomWord()
            clock?.startTimer(timeSet: calculateTime())
            editTextField.text = ""
        }
    }
    
    func calculateTime() -> Double {
        let secondsPerLetter = (1.0 - (Double(level) / 100))  * 0.6
        let timeLeft = (Double(currentWord.count) * secondsPerLetter) + 2
        return timeLeft
    }
    
    
    @IBAction func diffDownPressed(_ sender: Any) {
        let level = gameWords.getLevel()
        if level > 3 {
            gameWords.setLevel(level: level - 1)
            levelLabel.text = String(gameWords.getLevel())
        }
    }
    
    
    @IBAction func diffUpPressed(_ sender: Any) {
        let level = gameWords.getLevel()
        if level < 27  {
            gameWords.setLevel(level: level + 1)
            levelLabel.text = String(gameWords.getLevel())
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
