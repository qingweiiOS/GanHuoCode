//
//  TPCTechnicalObject.swift
//  
//
//  Created by tripleCC on 16/2/21.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(TPCTechnicalObject)
public final class TPCTechnicalObject: NSManagedObject ,TPCCoreDataHelper {
    public typealias RawType = [String : JSON]
    static var queryTimeString: String!
    init(context: NSManagedObjectContext, dict: RawType) {
        let entity = NSEntityDescription.entityForName(TPCTechnicalObject.entityName, inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        initializeWithRawType(dict)
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    convenience init(dict: RawType) {
        self.init(context: TPCCoreDataManager.shareInstance.managedObjectContext, dict: dict)
    }
    
    func initializeWithRawType(dict: RawType) {
        updatedAt = dict["updatedAt"]?.stringValue ?? ""
        who = dict["who"]?.stringValue ?? ""
        publishedAt = dict["publishedAt"]?.stringValue ?? ""
        objectId = dict["_id"]?.stringValue ?? ""
        used = dict["used"]?.numberValue ?? NSNumber()
        type = dict["type"]?.stringValue ?? ""
        createdAt = dict["createdAt"]?.stringValue ?? ""
        desc = dict["desc"]?.stringValue ?? ""
        url = dict["url"]?.stringValue ?? ""
    }
}

extension TPCCoreDataHelper where Self : TPCTechnicalObject {
    static var request: NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: TPCTechnicalObject.entityName)
        fetchRequest.fetchLimit = 1000
        fetchRequest.fetchBatchSize = 20;
        let predicate = NSPredicate(format: queryTimeString)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    static func fetchByTime(time: (year: Int, month: Int, day: Int)) -> [TPCTechnicalObject] {
        queryTimeString = String(format: "publishedAt CONTAINS '%04ld-%02ld-%02ld'", time.year, time.month, time.day)
        return fetch()
    }
    static func fetchById(id: String) -> [TPCTechnicalObject] {
        queryTimeString = "objectId == '\(id)'"
        return fetch()
    }
}

extension NSManagedObject {
    
}

infix operator !? { }
func !?<T: StringLiteralConvertible> (wrapped: T?, @autoclosure failureText: ()->String) -> T {
        assert(wrapped != nil, failureText)
        return wrapped ?? ""
}