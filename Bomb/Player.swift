//
//  Player.swift
//  Bomb
//
//  Created by MEI KU on 2019/9/7.
//  Copyright © 2019 Natalie KU. All rights reserved.
//

import Foundation
struct Player: Codable {
    var name: String
    var score: String
    var imageName: String
    
    static func readPlayersFromFile() -> [Player]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "players"), let players = try? propertyDecoder.decode([Player].self, from: data) {
            return players
        } else {
            return nil
        }
    }
    
    static func saveToFile(players: [Player]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(players) {
            UserDefaults.standard.set(data, forKey: "players")
        }
    }
    
}
