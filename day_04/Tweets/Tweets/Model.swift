//
//  Model.swift
//  Tweets
//
//  Created by Wahiba BELLAHCENE on 3/29/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    var description: String {
        return "(\(name), \(text)"
    }
    
    let name: String
    let text: String
}

protocol APITwitterDelegate: NSObjectProtocol {
    func treatTweet(tweets: [Tweet])
    func errorMethod(error: NSError)
}
