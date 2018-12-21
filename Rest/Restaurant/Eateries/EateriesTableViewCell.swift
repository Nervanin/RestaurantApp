//
//  EateriesTableViewCell.swift
//  Eateries
//
//  Created by Konstantin on 13.06.2018.
//  Copyright © 2018 Konstantin Meleshko. All rights reserved.
//

import UIKit

class EateriesTableViewCell: UITableViewCell {
    
    
    // image and labels on mainscreen 
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
