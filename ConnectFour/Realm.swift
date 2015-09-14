//
//  Player.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/14/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation
import RealmSwift


// Game model
class RLMGame: Object {
    dynamic var id = 0
    dynamic var winner: RLMPlayer?
    dynamic var loser: RLMPlayer?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// Player model
class RLMPlayer: Object {
    dynamic var id = 0
    dynamic var name = ""
    let games = List<RLMGame>()
    let wins = List<RLMGame>()
    let losses = List<RLMGame>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}