//
//  ViewController.swift
//  ex01
//
//  Created by Wahiba BELLAHCENE on 3/25/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBAction func clickButton(_ sender: UIButton) {
        helloLabel.text = "Hello World !"
        print("Hello World !")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

