//
//  CollectionViewCell.swift
//  day03
//
//  Created by Wahiba BELLAHCENE on 3/28/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var myImage: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var url: String? {
        didSet {
            if let urlExists = url {
                if let url = URL(string: urlExists)  {
                    displayActivityIndicator()
                    let qos = DispatchQoS.default.qosClass
                    let queue = DispatchQueue.global(qos: qos)
                    queue.async {
                        if let data = NSData(contentsOf: url) {
                            DispatchQueue.main.async {
                                let image = UIImage(data: data as Data)
                                self.myImage.image = image
                                self.removeActivityIndicator()
                            }
                        } else {
                            self.displayAlert(url.absoluteString)
                            self.url = nil
                        }
                    }
                }
            }
        }
    }
    
    func displayAlert(_ url: String!) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Erreur", message: "Impossible de charger \(url)", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func setActivityIndicator() {
        self.removeActivityIndicator()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }
    
    func displayActivityIndicator() {
        self.setActivityIndicator()
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.activityIndicator.center = self.myImage.center
            self.myImage.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
