//
//  MemoryGame.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import Foundation

//MARK:- Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var indexOfAlreadyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly }
        set { cards.indices.forEach {cards[$0].isFaceUp = $0 == newValue} }
    }
    
    init(numberOfPairOfCards: Int, createCardContent: ((Int) -> CardContent)) {
        cards = []
        for pairIndx in 0..<numberOfPairOfCards {
            let content = createCardContent(pairIndx)
            cards.append(Card(content: content, id: pairIndx*2))
            cards.append(Card(content: content, id: pairIndx*2+1))
        }
        cards.shuffle()
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched {
            if let previousIndx = indexOfAlreadyFaceUpCard {
                if cards[previousIndx].content == cards[choosenIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[previousIndx].isMatched = true
                }
                cards[choosenIndex].isFaceUp = true
            } else {
                indexOfAlreadyFaceUpCard = choosenIndex
            }
            
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
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
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
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

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
