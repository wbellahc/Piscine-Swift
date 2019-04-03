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
    let elasticityBehavior = UIDynamicItemBehavior()
    
    var initialCenter = CGPoint()
    var lastRotation = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.magnitude = 2
        elasticityBehavior.elasticity = 0.6
        dynamicAnimator?.addBehavior(gravityBehavior)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator?.addBehavior(collisionBehavior)
        dynamicAnimator?.addBehavior(elasticityBehavior)
    }
    
    @objc func panGesture(_ gesture: UIPanGestureRecognizer) {
        guard gesture.view != nil else {return}
        
        let piece = gesture.view
        
        switch gesture.state {
        case .began:
            self.initialCenter = piece!.center
            self.gravityBehavior.removeItem(piece!)
        case .ended:
            self.gravityBehavior.addItem(piece!)
        case .changed:
            let newCenter = gesture.location(in: piece?.superview)
            piece?.center = newCenter
            self.dynamicAnimator?.updateItem(usingCurrentState: piece!)
        default:
            piece?.center = initialCenter
        }
    }
    
    @objc func rotatedView(_ gesture: UIRotationGestureRecognizer) {
        let piece = gesture.view
        
        self.view.bringSubview(toFront: piece!)
        
        switch gesture.state {
        case .began:
            self.gravityBehavior.removeItem(piece!)
        case .ended:
            lastRotation = 0.0;
            self.gravityBehavior.addItem(piece!)
        default:
            self.dynamicAnimator?.updateItem(usingCurrentState: piece!)
        }
        let rotation = 0.0 - (lastRotation - gesture.rotation)
        let currentTrans = piece?.transform
        let newTrans = currentTrans!.rotated(by: rotation)
        piece?.transform = newTrans
        lastRotation = gesture.rotation
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.view)
        let dot = UIView(frame: CGRect(x: tapLocation.x,y: tapLocation.y,width: 100, height: 100))
        dot.layer.cornerRadius = arc4random_uniform(10) > arc4random_uniform(10) ? 50.0 : 0
        dot.backgroundColor = .random
        dot.clipsToBounds = true
        self.view.addSubview(dot)
        gravityBehavior.addItem(dot)
        collisionBehavior.addItem(dot)
        elasticityBehavior.addItem(dot)
        
        let initPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        dot.addGestureRecognizer(initPanGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotatedView(_:)))
        dot.addGestureRecognizer(rotateGesture)
        dot.isUserInteractionEnabled = true
        dot.isMultipleTouchEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
