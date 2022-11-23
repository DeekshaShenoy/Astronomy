//
//  AstronomyData+CoreDataProperties.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//
//

import Foundation
import CoreData


extension AstronomyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AstronomyData> {
        return NSFetchRequest<AstronomyData>(entityName: "AstronomyData")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var detail: String?

}

extension AstronomyData : Identifiable {

}
