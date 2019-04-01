//
//  AddTopicViewController.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/31/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController, API42Delegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    var me: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        print("done btn pressed")
        if let title = self.titleField.text, let content = self.contentField.text {
            print("title:", title)
            print("content:", content)
        }
    }
    
    func receiveData(data: Data) {
        do {
            if self.me == nil {
                let jsonDecoder = JSONDecoder()
                let me = try jsonDecoder.decode(User.self, from: data)
                print("my login:", me.login!)
                self.me = me
            }
            else {
                let res = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                if let err = res["error"] {
                    print("Error:", err)
                }
               
            }

        }
        catch(let err) {
            print(err)
        }
    }

    func getMe() {
        let url = NSURL(string: "https://api.intra.42.fr/v2/me")
        APIController.query(delegate: self, url: url!, method: "GET")
    }

    func createTopic(title: String, content: String) {
        let url = NSURL(string: "https://api.intra.42.fr/v2/topics")
        let messages_attributes: [Messages_attributes] = [Messages_attributes(author_id: "\(self.me!.id!)", content: content)]

        let topic = PostTopic(name: title, messages_attributes: messages_attributes)
        let dataBody = SetTopic(topic: topic)
        APIController.query(delegate: self, url: url!, method: "POST", dataBody: dataBody)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let title = titleField.text, let content = contentField.text, segue.identifier == "backToForum" {
            if !title.isEmpty && !content.isEmpty {
                self.createTopic(title: title, content: content)
                print("reload data !")
            }
        }
    }
}
