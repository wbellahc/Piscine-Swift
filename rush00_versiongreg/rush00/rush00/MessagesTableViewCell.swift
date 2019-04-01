//
//  MessagesTableViewCell.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var message: Message? {
        didSet {
            if let m = message {
                self.authorLabel?.text = m.author?.login
                self.dateLabel?.text = m.created_at
                self.contentLabel.text = m.content
                
            }
        }
    }
}
