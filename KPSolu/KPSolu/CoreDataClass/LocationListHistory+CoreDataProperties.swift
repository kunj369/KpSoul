//
//  LocationListHistory+CoreDataProperties.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationListHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationListHistory> {
        return NSFetchRequest<LocationListHistory>(entityName: "LocationListHistory")
    }

    @NSManaged public var dateEnd: NSDate?
    @NSManaged public var dateStart: NSDate?

}
