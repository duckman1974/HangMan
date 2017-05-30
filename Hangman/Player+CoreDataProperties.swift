//
//  Player+CoreDataProperties.swift
//  Hangman
//
//  Created by Kevin Reese on 5/17/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var user: String?
    @NSManaged public var player: NSSet?

}

// MARK: Generated accessors for player
extension Player {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Results)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Results)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}
