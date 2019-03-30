//
//  TweetViewCell.swift
//  Tweets
//
//  Created by Wahiba BELLAHCENE on 3/29/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myTextLabel: UILabel!
    
    var tweet : Tweet? {
        didSet {
            if let t = tweet {
                nameLabel?.text = t.name
                myTextLabel?.text = t.text
            }
        }
    }

}
