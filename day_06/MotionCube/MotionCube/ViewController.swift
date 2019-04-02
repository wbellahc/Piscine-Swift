//
//  ViewController.swift
//  MotionCube
//
//  Created by Wahiba BELLAHCENE on 4/2/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator?
    let gravityBehavior = UIGravityBehavior()
    var collisionBehavior = UICollisionBehavior()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.magnitude = 2
        dynamicAnimator?.addBehavior(gravityBehavior)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator?.addBehavior(collisionBehavior)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.view)
        let dot = UIView(frame: CGRect(x: tapLocation.x,y: tapLocation.y,width: 100, height: 100))
        dot.backgroundColor = UIColor.gray
        self.view.addSubview(dot)
        gravityBehavior.addItem(dot)
        collisionBehavior.addItem(dot)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

