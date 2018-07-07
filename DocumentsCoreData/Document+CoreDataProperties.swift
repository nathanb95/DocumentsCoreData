//
//  Document+CoreDataProperties.swift
//  DocumentsCoreData
//
//  Created by Nathaniel Banderas on 7/6/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var size: Int64
    @NSManaged public var rawDate: NSDate?

}
