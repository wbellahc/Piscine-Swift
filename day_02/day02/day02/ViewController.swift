//
//  ViewController.swift
//  day02
//
//  Created by Wahiba BELLAHCENE on 3/27/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print(segue.identifier as Any)
        if (segue.identifier == "backSegue") {
            self.myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.deaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "deathCell") as! DeathTableViewCell
        cell.death = Data.deaths[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
