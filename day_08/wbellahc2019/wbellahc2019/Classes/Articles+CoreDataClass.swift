//
//  Articles+CoreDataClass.swift
//  Pods-wbellahc2019_Example
//
//  Created by Wahiba BELLAHCENE on 4/5/19.
//
//

import Foundation
import CoreData

@objc(Articles)
public class Articles: NSManagedObject {
    
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var modif_date: NSDate?
    
    override public var description: String {
        return "Article: \n- Title : \(String(describing: self.title))\n- Language : \(String(describing: self.language))\n- Image : \(String(describing: self.image))\n- Creation date :\(String(describing: self.creation_date))\n- Date of modif : \(String(describing: self.modif_date))- Content : \(String(describing: self.content))"
    }
}
