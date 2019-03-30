//
//  ViewController.swift
//  Tweets
//
//  Created by Wahiba BELLAHCENE on 3/29/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var controller : APIController!
    var tweetsList : [Tweet] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? TweetViewCell {
            cell.tweet = tweetsList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func treatTweet(tweets: [Tweet]) {
        DispatchQueue.main.async {
            self.tweetsList = tweets
            self.tableView.reloadData()
        }
        print(tweets)
    }
    
    func errorMethod(error: NSError) {
        print(error)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let CUSTOMER_KEY = "urFzeodmWSpqiVG6olPF7M6Jg"
        let CUSTOMER_SECRET = "NspP6q0RPzMkdtq8hYSBRxzlS3HNu80do5hdcweKF1IPvavFdZ"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: [])
        
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        let token = dic["access_token"] as! String
                        self.controller = APIController(delegate: self, token: token)
                        self.controller.requestTweets(topic: "ecole 42")
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

