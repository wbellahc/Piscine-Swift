//
//  ViewController.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var token: String?
    var webView: WKWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=43bbc6bc08f75bf4d46b6d47353eca2d71772a9eff69da0fbaa7f111c796e6db&redirect_uri=https%3A%2F%2Fwww.42.fr%2F&response_type=code")
        let req = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.load(req)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var dict = [String:String]()
        let components = URLComponents(url: webView.url!, resolvingAgainstBaseURL: false)!
        if let queryItems = components.queryItems {
            for item in queryItems {
                dict[item.name] = item.value!
            }
        }
        if let code = dict["code"], !code.isEmpty {
            self.token = code
            performSegue(withIdentifier: "successLogin", sender: code)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successLogin" {
            webView.goBack()
            let vc = segue.destination as! ForumViewController
            vc.token = self.token
        }
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print("token:", self.token as Any)
        print("unWindSegue identifier:", segue.identifier!)
    }
}

