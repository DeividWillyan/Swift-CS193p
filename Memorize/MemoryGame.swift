//
//  MemoryGame.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 14/12/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card choose: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2))
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
