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
        for i in 0..<numberOfPairOfCards {
            let content = createCardContent(i)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
