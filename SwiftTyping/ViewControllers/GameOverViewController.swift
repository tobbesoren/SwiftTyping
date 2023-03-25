//
//  GameOverViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-24.
//

import UIKit

class GameOverViewController: UIViewController {
    
    var score: Int?
    var defaults = UserDefaults.standard

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        name = defaults.object(forKey: "PlayerName") as? String
        nameLabel.text = "\(name ?? "Incognito")'s score:"
        scoreLabel.text = String(score ?? 0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAndExit(_ sender: Any) {
        
        
        var hiScores: [[String?]] = defaults.object(forKey:"HiScores") as? [[String?]] ?? [[String?]]()
        if score ?? 0 > 0 {
            let newEntry = [String(score ?? 0), name]
            hiScores.append(newEntry)
            hiScores.sort(by: {Int($0[0] ?? "") ?? 0 > Int($1[0] ?? "") ?? 0})
            defaults.set(hiScores, forKey: "HiScores")
        }
        performSegue(withIdentifier: "unWindSegue", sender: nil)
        
        for entry in hiScores {
            print(entry)
        }
    }
    
    func sortByScore(array1: [String?], array2: [String?]) throws -> Bool {
        if array1[0] ?? "" < array2[0] ?? "" {
            return true
        } else {
            return false
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
