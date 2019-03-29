//
//  ScrollViewController.swift
//  day03
//
//  Created by Wahiba BELLAHCENE on 3/28/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        var minZoom = min(self.scrollView.bounds.size.width / imageView.bounds.size.width, self.scrollView.bounds.size.height / imageView.bounds.size.height);
        if (minZoom > 1.0) {
            minZoom = 1.0
        }
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        scrollView.maximumZoomScale = 100
        scrollView.minimumZoomScale = minZoom
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
