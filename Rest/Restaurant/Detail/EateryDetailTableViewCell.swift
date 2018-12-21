//
//  EateryDetailTableViewCell.swift
//  Eateries
//
//  Created by Konstantin on 20.06.2018.
//  Copyright © 2018 Konstantin Meleshko. All rights reserved.
//

import UIKit

// property of labels on secodscreen 
class EateryDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
