//
//  RepliesTableViewCell.swift
//  rush00
//
//  Created by Wahiba BELLAHCENE on 3/31/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class RepliesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var reply: Replies? {
        didSet {
            if let r = reply {
                self.dateLabel?.text = r.created_at
                self.loginLabel?.text = r.author?.login
                self.contentLabel?.text = r.content
            }
        }
    }
}
