//
//  ViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var startLevelLabel: UILabel!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name: String = defaults.object(forKey: "PlayerName") as? String {
            nameEdit.text = name
        } else {
            defaults.set("Incognito", forKey: "PlayerName")
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        if nameEdit.text != "" {
            defaults.set(nameEdit.text, forKey: "PlayerName")
        }
        performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
    
    @IBAction func unwindToStart(segue: UIStoryboardSegue) {}
        
    
   

}

