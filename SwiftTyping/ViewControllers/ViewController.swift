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
    
    let defaults = DefaultsHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.getName() != "Incognito" {
            nameEdit.text = defaults.getName()
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        if let name = nameEdit.text {
            if name == "" {
                defaults.setName(name: "Incognito")
            } else {
                defaults.setName(name: name)
            }
        }
        performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
        
    @IBAction func unwindToStart(segue: UIStoryboardSegue) {}
        
        
    }
