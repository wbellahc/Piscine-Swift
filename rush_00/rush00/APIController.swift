//
//  APIController.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import UIKit

class APIController {    
    static let CONSUMER_KEY: String = "#"
    static let CONSUMER_SECRET: String = "#"
    static var token: String?
    static var accessToken: String?
    
    static func getToken(token: String) {
        self.token = token
    }

    static func getAccessToken(completionHandler: @escaping () -> Swift.Void) {
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        let req = NSMutableURLRequest(url: url! as URL)
        let bodyData = "grant_type=authorization_code&client_id=\(CONSUMER_KEY)&client_secret=\(CONSUMER_SECRET)&code=\(APIController.token!)&redirect_uri=https://www.42.fr/"
        req.httpBody = bodyData.data(using: String.Encoding.utf8)
        req.httpMethod = "POST"
        req.setValue("Bearer " + APIController.token!, forHTTPHeaderField: "Authorization")
        req.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) {
            (data, res, error) in
            if let err = error {
                print(err)
            }
            else if let jsonData = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let access = dic["access_token"] as? String {
                            APIController.accessToken = access
                            completionHandler()
                        }
                    }
                }
                catch(let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    static func query(delegate: API42Delegate, url: NSURL, method: String, dataBody: SetTopic? = nil) {
        let req = NSMutableURLRequest(url: url as URL)
        req.httpMethod = method
        req.setValue("Bearer " + APIController.accessToken!, forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = dataBody, method == "POST" {
            print("post is called")
            if let body = try? JSONEncoder().encode(data as SetTopic) {
                req.httpBody = body
            }
        }
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) {
            (data, res, error) in
            if let err = error {
                print("Error:", err)
            }
            else {
                delegate.receiveData(data: data!)
            }
        }
        task.resume()
    }
    
//    func getError(error: NSError) {
//        print("error: \(error)")
//        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        delegate.present(alert, animated: true, completion: nil)
//    }
}
