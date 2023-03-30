//
//  HiScoreTableViewController.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-25.
//

import UIKit

class HiScoreTableViewController: UITableViewController {
    
    //let defaults = UserDefaults.standard
    let defaults = DefaultsHandler()
    var hiScores = [[String?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiScores = defaults.getHiScores()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! HiScoreTableViewCell
        let scoreEntry = hiScores[indexPath.row]
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.scoreLabel.text = scoreEntry[0]
        cell.nameLabel.text = scoreEntry[1]
        
        return cell
    }
}
