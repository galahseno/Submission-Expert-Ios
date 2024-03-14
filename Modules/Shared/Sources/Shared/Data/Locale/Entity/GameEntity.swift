//
//  GameEntity.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import RealmSwift

public class GameEntity: Object {

    @objc dynamic public var id: String = ""
    @objc dynamic public var name: String = ""
    @objc dynamic public var rating: Double = 0.0
    @objc dynamic public var backgroundImage: String = ""
    @objc dynamic public var released: String = ""

    override public class func primaryKey() -> String? {
        return "id"
    }
}
