//
//  Articles+CoreDataProperties.swift
//  Pods-wbellahc2019_Example
//
//  Created by Wahiba BELLAHCENE on 4/5/19.
//
//

import Foundation
import CoreData


extension Articles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Articles> {
        return NSFetchRequest<Articles>(entityName: "Articles")
    }
}
