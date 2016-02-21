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
    var queryTimeString: String!
    init(context: NSManagedObjectContext, dict: RawType) {
        let entity = NSEntityDescription.entityForName(TPCTechnicalObject.entityName, inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        initializeWithRawType(dict)
    }
    
    convenience init(dict: RawType) {
        self.init(context: TPCCoreDataManager.shareInstance.managedObjectContext, dict: dict)
    }
    
    func initializeWithRawType(dict: RawType) {
        updatedAt = dict["updatedAt"]?.stringValue
        who = dict["who"]?.stringValue
        publishedAt = dict["publishedAt"]?.stringValue
        objectId = dict["objectId"]?.stringValue
        used = dict["used"]?.numberValue
        type = dict["type"]?.stringValue
        createdAt = dict["createdAt"]?.stringValue
        desc = dict["desc"]?.stringValue
        url = dict["url"]?.stringValue
    }
}

extension TPCCoreDataHelper where Self : TPCTechnicalObject {
    var request: NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: TPCTechnicalObject.entityName)
        fetchRequest.fetchBatchSize = 20
        fetchRequest.fetchLimit = 50
        let predicate = NSPredicate(format: "publishedAt CONTAINS %@", queryTimeString)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    func fetchByTime(time: (year: NSTimeInterval, month: NSTimeInterval, day: NSTimeInterval)) -> [TPCTechnicalObject] {
        queryTimeString = String(format: "%4ld-%2ld-%2ld", time.year, time.month, time.day)
        return fetch()
    }
    
}