//
//  PlacesTableViewCell.swift
//  Kanto
//
//  Created by Wahiba BELLAHCENE on 4/1/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    
    var place : String? {
        didSet {
            if let p = place {
                placeLabel.text = String(describing: p)
            }
        }
    }
}
