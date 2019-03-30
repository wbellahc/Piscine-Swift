//
//  APIController.swift
//  Tweets
//
//  Created by Wahiba BELLAHCENE on 3/29/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class APIController {
    
    weak var delegate : APITwitterDelegate?
    let token : String
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func requestTweets(topic: String) {
        let topicEncoded = topic.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(topicEncoded!)&count=100&result_type=recent&tweet_mode=extended&lang=fr")
        var request = URLRequest(url: url! as URL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        let duty = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let statuses: [NSDictionary] = dic["statuses"] as? [NSDictionary] {
                            var tweets: [Tweet] = []
                            for status in statuses {
                                guard let name = (status["user"] as? NSDictionary)?["name"] as? String,
                                    let text = status["full_text"] as? String else { continue }
                                    tweets.append(Tweet(name: name, text: text))
                            }
                            self.delegate?.treatTweet(tweets: tweets)
                        }
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        duty.resume()
    }
}
