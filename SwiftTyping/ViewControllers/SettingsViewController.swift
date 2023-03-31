//
//  SettingsViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

/*
 Settings. Uses two picker views to set difficulty and startLevel.
 Saves to userDefaults.
 */
class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var picker1Options: [String] = []
    var picker2Options: [String] = []
    
    let defaults = DefaultsHandler()
    
    var difficulty: Int?
    var startLevel: Int?
    
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    @IBOutlet weak var startLevelPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        difficulty = defaults.getDifficulty()
        startLevel = defaults.getLevel()
       
        picker1Options = ["Easy", "Normal", "Hard"]
        for level in 1...25 {
            picker2Options.append(String(level))
        }
        
        let defaultPicker1Row = (difficulty ?? 0) - 1
        let defaultPicker2Row = (startLevel ?? 0) - 1
        
        difficultyPickerView.selectRow(defaultPicker1Row , inComponent: 0, animated: false)
        pickerView(difficultyPickerView, didSelectRow: defaultPicker1Row , inComponent: 0)
        
        startLevelPickerView.selectRow(defaultPicker2Row , inComponent: 0, animated: false)
        pickerView(startLevelPickerView, didSelectRow: defaultPicker2Row , inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return picker1Options.count
        } else {
            return picker2Options.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return picker1Options[row]
        } else {
            return picker2Options[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var key = ""
        if pickerView.tag == 1 {
            key = defaults.difficultyString
        } else {
            key = defaults.levelString
        }
        saveSelected(row: row, key: key)
    }
    
    func saveSelected(row : Int, key: String) {
        if key == defaults.difficultyString {
            defaults.setDifficulty(difficulty: row + 1)
        } else {
            defaults.setLevel(level: row + 1)
        }
    }
    
    
    @IBAction func returnPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToStart", sender: nil)
    }
}
