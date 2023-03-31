//
//  ViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit


/*
 Main menu.
 The app starts here.
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var startLevelLabel: UILabel!
    
    let defaults = DefaultsHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
          
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if defaults.getName() != "Incognito" {
            nameEdit.text = defaults.getName()
        }
        setLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.updateDefaults()
        setLabels()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
            return
        }
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setLabels() {
        difficultyLabel.text = defaults.getDifficultyString()
        startLevelLabel.text = "Level: \(String(defaults.getLevel()))"
    }
    
    @IBAction func checkNameLength(_ sender: Any) {
        if nameEdit.text?.count ?? 0 > 10 {
            let newString = String(nameEdit.text?.prefix(10) ?? "")
            nameEdit.text = newString
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
