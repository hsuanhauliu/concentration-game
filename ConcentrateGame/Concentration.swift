//
//  Concentration.swift
//  The main class model for concentration game.
//
//  Created by Loki on 7/26/18.
//  Copyright © 2018 Hsuan-Hau Liu. All rights reserved.
//

import Foundation

class Concentration
{
    // list of cards
    var cards = [Card]()
    
    // index of the face up card
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // function for choosing a card
    func chooseCard(at index: Int) -> Bool {
        var matched = false
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return matched
    }
    
    // reset the game
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards = cards.shuffled()
    }
    
    // constructor of the concentration game
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let currCard = Card()
            cards += [currCard, currCard]
        }
        
        cards = cards.shuffled()
    }
}
