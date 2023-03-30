//
//  SettingsViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var picker1Options: [String] = []
    var picker2Options: [String] = []
    let defaults = UserDefaults.standard
    
    var difficulty: Int?
    var startLevel: Int?
    
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    @IBOutlet weak var startLevelPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.integer(forKey: "Difficulty") < 0 {
            defaults.set(1, forKey: "Difficulty")
        }
        difficulty = defaults.integer(forKey: "Difficulty")
        
        if defaults.integer(forKey: "StartLevel") < 0 {
            defaults.set(3, forKey: "StartLevel")
        }
        startLevel = defaults.integer(forKey: "StartLevel")
       
        picker1Options = ["Easy", "Normal", "Hard"]
        for level in 1...25 {
            picker2Options.append(String(level))
        }
        
        let defaultPicker1Row = difficulty
        let defaultPicker2Row = startLevel
        
        difficultyPickerView.selectRow(defaultPicker1Row ?? 0, inComponent: 0, animated: false)
        pickerView(difficultyPickerView, didSelectRow: defaultPicker1Row ?? 0, inComponent: 0)
        
        startLevelPickerView.selectRow(defaultPicker2Row ?? 0, inComponent: 0, animated: false)
        pickerView(startLevelPickerView, didSelectRow: defaultPicker2Row ?? 0, inComponent: 0)
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
            key = "Difficulty"
        } else {
            key = "StartLevel"
        }
        saveSelected(row: row, key: key)
    }
    
    func saveSelected(row : Int, key: String) {
        defaults.set(row, forKey: key )
        defaults.synchronize()
    }
    
    
    @IBAction func returnPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToStart", sender: nil)
    }
}
