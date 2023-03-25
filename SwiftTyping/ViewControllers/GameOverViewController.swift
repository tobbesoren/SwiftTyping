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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score ?? 0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAndExit(_ sender: Any) {
        var hiScores: [Int] = defaults.object(forKey:"Hi-scores") as? [Int] ?? [Int]()
        if score ?? 0 > 0 {
            hiScores.append(score ?? 0)
            hiScores.sort()
            defaults.set(hiScores, forKey: "Hi-scores")
            performSegue(withIdentifier: "unWindSegue", sender: nil)
        }
        
        for entry in hiScores {
            print(entry)
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
