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
    }
}

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
