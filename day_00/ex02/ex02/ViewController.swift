//
//  ViewController.swift
//  ex02
//
//  Created by Wahiba BELLAHCENE on 3/25/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var nbrOnScreen: Double = 0
    var prevNumber: Double = 0
    var operation = 0
    var res: Double = 0.0
    var theNbr: String! = ""
    var operatorNext = false
    
    enum calculError: Error {
        case anError
    }
    
    func verifyNbrOnScreen() throws {
        if theNbr != "" && theNbr != String(operation) && theNbr != nil {
            nbrOnScreen = Double(theNbr)!
        } else {
            throw calculError.anError
        }
    }
    
    @IBOutlet weak var nbrLabel: UILabel!
    
    func printNumber() {
        nbrLabel.text = theNbr
    }
    
    func savePrevNumber() {
        prevNumber = Double(theNbr)!
        theNbr = ""
        printNumber()
    }
    
    @IBAction func calculButton(_ sender: UIButton) {
        operatorNext = false
        do {
            try verifyNbrOnScreen()
        } catch let error {
            print("Error: \(error)")
            return;
        }
        if operation == 15 {
            res = prevNumber + nbrOnScreen
        }
        if operation == 14 {
            res = prevNumber - nbrOnScreen
        }
        if operation == 13 {
            res = prevNumber * nbrOnScreen
        }
        if operation == 12 {
            if (nbrOnScreen == 0) {
                let alert = UIAlertController(title: "Erreur", message: "Impossible de diviser par 0", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Retour", style: .cancel, handler: nil)
                
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
            }
            else {
                res = prevNumber / nbrOnScreen
            }
        }
        theNbr = String(res)
        printNumber()
        prevNumber = res
        res = Double(theNbr)!
        operation = 0
    }
    
    @IBAction func negButton(_ sender: UIButton) {
        if var neg: Double = Double(nbrLabel.text!) {
            neg = neg * (-1)
            theNbr = String(neg)
            printNumber()
            print(neg)
        }
        else {
            return;
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        nbrLabel.text = ""
        theNbr = ""
        prevNumber = 0
        nbrOnScreen = 0
        operation = 0
        print(sender.currentTitle ?? "AC")
    }
    
    @IBAction func operatorButton(_ sender: UIButton) {
        if sender.tag >= 12 && sender.tag <= 15 {
            operation = sender.tag
            if theNbr != "" {
                savePrevNumber()
                operatorNext = false
            }
        }
        print(theNbr + String(sender.tag) + String(operation))
    }
    
    @IBAction func nbrButton(_ sender: UIButton) {
        if operatorNext == false {
            theNbr = String(sender.tag-1)
            res = Double(theNbr)!
            printNumber()
            print(sender.currentTitle ?? 0)
            operatorNext = true
        }
        else {
            if sender.tag >= 1 && sender.tag <= 10 {
                theNbr = theNbr! + String(sender.tag-1)
                printNumber()
                print(sender.currentTitle ?? 0)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

