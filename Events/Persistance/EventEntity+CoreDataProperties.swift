//
//  EventEntity+CoreDataProperties.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//
//

import Foundation
import CoreData


extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var image: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var place: String?

}

extension EventEntity : Identifiable {

}
