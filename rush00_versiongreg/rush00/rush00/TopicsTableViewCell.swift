//
//  TopicsTableViewCell.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {

    @IBOutlet weak var topicCellView: TopicsTableViewCell!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var topic: Topic? {
        didSet {
            if let t = topic {
                self.dateLabel?.text = t.created_at
                self.authorLabel?.text = (t.author?.login)!
                self.nameLabel?.text = t.name
            }
        }
    }
}
