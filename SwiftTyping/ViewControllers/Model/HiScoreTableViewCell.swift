//
//  HiScoreTableViewCell.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-25.
//

import UIKit

class HiScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
