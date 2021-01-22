//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 14/12/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Acess to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards;
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGamer() {
        model = EmojiMemoryGame.createMemoryGame();
    }
}
