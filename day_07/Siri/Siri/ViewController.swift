//
//  ViewController.swift
//  Siri
//
//  Created by Wahiba BELLAHCENE on 4/4/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UITextField!
    @IBOutlet weak var respLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    var client: DarkSkyClient?
    
    let bot = RecastAIClient(token : "773e6684e4c65d4eda24aaa5916cf11b", language: "en")
    
    @IBAction func sendRequest(_ sender: UIButton) {
        DispatchQueue.main.async {
            if (!(self.textLabel.text?.isEmpty)!)
            {
                self.bot.textRequest(self.textLabel.text!, successHandler: self.recastRequestDone, failureHandle: self.recastRequestError)
            }
        }
    }
    
    func recastRequestDone(_ response: Response) {
        let intent = response.intent()
        print("intent: \(String(describing: intent?.slug))")
        
        if let location = response.get(entity: "location") {
            print("location : \(String(describing: location))")
            
            guard let lat = location["lat"] as? Double, let lng = location["lng"] as? Double else {return}
            client?.getForecast(latitude: lat, longitude: lng) {
                result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let currentForecast, _):
                        if let current = currentForecast.currently {
                            guard let sum = current.summary else {return}
                            guard let temperature = current.temperature else {return}
                            self.respLabel.text = "The temperature is : \(temperature) .C"
                            self.sumLabel.text = "Summary: \(sum)"
                        }
                    case .failure(let error):
                        print(error)
                        self.respLabel.text = "\(error)"
                    }
                }
            }
        } else {
            self.respLabel.text = "Error 404"
        }
    }
    
    func recastRequestError(_ error: Error) {
        DispatchQueue.main.async {
            print(error)
            self.respLabel.text = "\(error)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        client = DarkSkyClient(apiKey: "366685204e7b0d5f27276c045cbd85dd")
        client?.units = .auto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

