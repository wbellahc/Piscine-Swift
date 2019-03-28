//
//  DeathTableViewCell.swift
//  day02
//
//  Created by Wahiba BELLAHCENE on 3/27/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {
    
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                yearLabel?.text = String(d.2)
                titleLabel?.text = String(d.0)
                detailLabel?.text = String(d.1)
            }
        }
    }
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //override func awakeFromNib() {
     //   super.awakeFromNib()
        // Initialization code
    //}

    //override func setSelected(_ selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    //}

}
