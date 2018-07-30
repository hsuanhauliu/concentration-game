//
//  Card.swift
//  ConcentrateGame
//
//  Created by Loki on 7/26/18.
//  Copyright © 2018 Hsuan-Hau Liu. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func generateUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.generateUniqueIdentifier()
    }
}
