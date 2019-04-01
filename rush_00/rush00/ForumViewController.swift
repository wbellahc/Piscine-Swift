//
//  ForumViewController.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, API42Delegate {
    var topics = [Topic]()
    var token: String?
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func logOut(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "logout", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        self.navigationItem.setHidesBackButton(true, animated:true);
        APIController.getToken(token: token!)
        APIController.getAccessToken {
            self.getTopics()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getTopics()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicsTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.topic = self.topics[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TopicsTableViewCell
        if cell?.authorLabel != nil {
            performSegue(withIdentifier: "goToMessages", sender: self.topics[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout" {
            let vc = segue.destination as! ViewController
            vc.token = nil
        }
        else if segue.identifier == "goToMessages" {
            if let mvc = segue.destination as? MessagesViewController, let topic = sender as? Topic {
                mvc.topic = topic
                mvc.token = self.token
            }
        }
    }

    func receiveData(data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let topicsData = try jsonDecoder.decode([Topic].self, from: data)
            for topic in topicsData {
                self.topics.append(topic)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch(let err) {
            print(err)
        }
    }
    
    func getTopics() {
        let url = NSURL(string: "https://api.intra.42.fr/v2/topics")
        APIController.query(delegate: self, url: url!, method: "GET")
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        self.getTopics()
    }

}
