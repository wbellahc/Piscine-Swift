//
//  ViewController.swift
//  day03
//
//  Created by Wahiba BELLAHCENE on 3/28/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let images: [String] = [
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia19821-nustar_xrt_sun.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e007722.jpg",
        "https://images-assets.nasa.gov/image/PIA23121/PIA23121~orig.jpg",
        "https://images-assets.nasa.gov/image/PIA18033/PIA18033~orig.jpg",
        "https://images-assets.nasa.gov/image/PIA04921/PIA04921~orig.jpg",
        "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia20493-1041.jpg"
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.url = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.url != nil {
            performSegue(withIdentifier: "backSegue", sender: cell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegue" {
            let vc = segue.destination as! ScrollViewController
            vc.imageView = UIImageView(image: (sender as! CollectionViewCell).myImage.image)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

