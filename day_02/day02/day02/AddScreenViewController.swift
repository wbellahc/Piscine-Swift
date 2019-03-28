//
//  AddScreenViewController.swift
//  day02
//
//  Created by Wahiba BELLAHCENE on 3/27/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addDeath: UITextView!
    @IBOutlet weak var addTime: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegue" {
            if let vc = segue.destination as? ViewController {
                vc.title = "Back from 2nd View"
                if addName.text != "" {
                    print("New death added: name \(addName.text!), death: \(addDeath.text), date: \(addTime.date)")
                    Data.deaths.append((n: addName.text!, dD: addDeath.text, date: dateFormatter.string(from: addTime.date)))
                }
            }
        }
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        performSegue(withIdentifier: "backSegue", sender: "Foo")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd-MM-yy HH:mm"
        addTime.minimumDate = Date()
        addName.placeholder = "Name"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
