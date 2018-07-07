//
//  Document+CoreDataClass.swift
//  DocumentsCoreData
//
//  Created by Nathaniel Banderas on 7/6/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, content: String?, size: Int64, date: Date) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        self.init(entity: Document.entity(), insertInto: managedContext)
        
        self.name = name
        self.content = content
        self.size = size
        self.date = date
    }
}
