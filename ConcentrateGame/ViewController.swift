//
//  ViewController.swift
//  Controller for our concentration game.
//
//  Created by Loki on 7/25/18.
//  Copyright © 2018 Hsuan-Hau Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // initialize a game
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // keep track of player scores and turns
    var player_1_turn = true
    var turn = 1 {didSet {playerTurn.text = "Player \(turn)'s turn" } }
    var player_1_score = 0 { didSet { flipCountLabel_1.text = "Player 1: \(player_1_score)" } }
    var player_2_score = 0 { didSet { flipCountLabel_2.text = "Player 2: \(player_2_score)" } }
    
    @IBOutlet weak var playerTurn: UILabel!
    @IBOutlet weak var flipCountLabel_1: UILabel!
    @IBOutlet weak var flipCountLabel_2: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var selectedTwoCards = true
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            selectedTwoCards = !selectedTwoCards
            let matched = game.chooseCard(at: cardNumber)
            
            if selectedTwoCards {
                if matched {
                    if player_1_turn {
                        player_1_score += 1
                    } else {
                        player_2_score += 1
                    }
                } else {
                    // switch turn
                    player_1_turn = !player_1_turn
                    if turn == 1 {
                        turn = 2
                    } else {
                        turn = 1
                    }
                }
            }
            // update view
            updateViewFromModel()
        } else {
            print("Exception caught")
        }
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        player_1_turn = true
        turn = 1
        player_1_score = 0
        player_2_score = 0
        game.resetGame()
        resetView()
    }
    
    func resetView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🍖", "🍔", "🍟", "🥨", "🍕", "🥓"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

