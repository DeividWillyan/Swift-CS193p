//
//  MemoryGame.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 14/12/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card choose: \(card)")
        if let chosenIndex = cards.firstIndex(card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
        }
    }
        
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2))
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
        
        
        
        
        
        
        
        
        // MARK: - Bonus Time
               // can be zero which means "no bonus available" for this card
               var bonusTimeLimit: TimeInterval = 6
               
               // how long this card has ever been face up
               private var faceUpTime: TimeInterval {
                   if let lastFaceUpDate = self.lastFaceUpDate {
                       return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                   }
                   else {
                       return pastFaceUpTime
                   }
               }
               // the last time this card was turned face up (and is still face up)
               var lastFaceUpDate: Date?
               // the accumulated time this card has been face up in the past
               // (i.e. not including the current time it's been face up if it is currently so)
               var pastFaceUpTime: TimeInterval = 0
               
               // how much time left before the bonus opportunity runs out
               var bonusTimeRemaining: TimeInterval {
                   max(0, bonusTimeLimit - faceUpTime)
               }
               // percentage of the bonus time remaining
               var bonusRemaining: Double {
                   (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
               }
               // whether the card was matched during the bonus time period
               var hasEarnedBonus: Bool {
                   isFaceUp && bonusTimeRemaining > 0
               }
               // whether we are currently face up, unmatched and have not yet uesd up the bonus window
               var isConsumingBonusTime: Bool {
                   isFaceUp && !isMatched && bonusTimeRemaining > 0
               }
               
               // called when the card transitions to face up state
               private mutating func startUsingBonusTime() {
                   if isConsumingBonusTime, lastFaceUpDate == nil {
                       lastFaceUpDate = Date()
                   }
               }
               // called when the card goes back face down (or gets matched)
               private mutating func stopUsingBonusTime() {
                   pastFaceUpTime = faceUpTime
                   self.lastFaceUpDate = nil
               }
        
    }
}
