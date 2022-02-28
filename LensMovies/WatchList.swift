//
//  FavoriteMovies.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation
import CoreData

@objc(WatchList)
public class WatchList: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String

}

extension WatchList {
    static func fetchAll() -> NSFetchRequest<WatchList> {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        return request
    }
}
