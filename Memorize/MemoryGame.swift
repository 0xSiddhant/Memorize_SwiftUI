//
//  MemoryGame.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import Foundation

//MARK:- Model
struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairOfCards: Int, createCardContent: ((Int) -> CardContent)) {
        cards = [Card]()
        for pairIndx in 0..<numberOfPairOfCards {
            let content = createCardContent(pairIndx)
            cards.append(Card(content: content, id: pairIndx*2))
            cards.append(Card(content: content, id: pairIndx*2+1))
        }
    }
    
    mutating func choose(_ card: Card) {
        let choosenIndex = index(of: card)
        cards[choosenIndex].isFaceUp.toggle()
    }
    
    private func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
