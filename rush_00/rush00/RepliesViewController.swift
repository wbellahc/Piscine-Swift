//
//  RepliesViewController.swift
//  rush00
//
//  Created by Wahiba BELLAHCENE on 3/31/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class RepliesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, API42Delegate {
    
    @IBOutlet weak var tableView: UITableView!
    var replies = [Replies]()
    var topic: Topic?
    var message: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getReplies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! RepliesTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.reply = self.replies[indexPath.row]
        return cell
    }
    
    func receiveData(data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let messagesData = try jsonDecoder.decode([Replies].self, from: data)
            for reply in messagesData {
                self.replies.append(reply)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch(let err) {
            self.getError(error: err as NSError)
        }
    }
    
    func getReplies() {
        let url = NSURL(string: "https://api.intra.42.fr/v2/topics/\(self.topic?.id! ?? 0)/messages/\(self.message?.id! ?? 0)/messages")
        APIController.query(delegate: self, url: url!, method: "GET")
    }
    
    func getError(error: NSError) {
        print("error: \(error)")
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
