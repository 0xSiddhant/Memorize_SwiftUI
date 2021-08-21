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
    private var indexOfAlreadyFaceUpCard: Int?
    
    init(numberOfPairOfCards: Int, createCardContent: ((Int) -> CardContent)) {
        cards = [Card]()
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
                indexOfAlreadyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfAlreadyFaceUpCard = choosenIndex
            }
            
            cards[choosenIndex].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
