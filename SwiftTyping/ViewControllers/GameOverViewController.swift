//
//  GameOverViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-24.
//

import UIKit

/*
 Game Over screen. Shows the player´s name and score, and lets them
 save the score to userDefaults.
 */
class GameOverViewController: UIViewController {
    
    var score: Int?
    var name: String?
   
    let defaults = DefaultsHandler()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        name = defaults.getName()
        nameLabel.text = "\(name ?? "")'s score:"
        scoreLabel.text = String(score ?? 0)
    }
    
    @IBAction func saveAndExit(_ sender: Any) {
        
        let newEntry: [String] = [String(score ?? 0), name ?? ""]
        defaults.addHiScore(newScore: newEntry)

        performSegue(withIdentifier: "unWindSegue", sender: nil)
    }
    
    func sortByScore(array1: [String?], array2: [String?]) throws -> Bool {
        if array1[0] ?? "" < array2[0] ?? "" {
            return true
        } else {
            return false
        }
    }
}
