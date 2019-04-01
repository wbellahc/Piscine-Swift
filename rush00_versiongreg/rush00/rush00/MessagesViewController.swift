//
//  MessagesViewController.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, API42Delegate {

    @IBOutlet weak var tableView: UITableView!
    var messages = [Message]()
    var topic: Topic?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        cell.message = self.messages[indexPath.row]
        return cell
    }

    func receiveData(data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let messagesData = try jsonDecoder.decode([Message].self, from: data)
            for message in messagesData {
                self.messages.append(message)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch(let err) {
            self.getError(error: err as NSError)
        }
    }
    
    func getMessages() {
        let url = NSURL(string: "https://api.intra.42.fr/v2/topics/\(self.topic?.id! ?? 0)/messages")
        APIController.query(delegate: self, url: url!, method: "GET")
    }
    
    func getError(error: NSError) {
        print("error: \(error)")
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
