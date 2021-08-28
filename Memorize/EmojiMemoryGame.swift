//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

//MARK: ViewModel

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["✈️", "🚗", "🚌", "🚁","⛵️", "🛳", "🚄", "🚞", "🦼", "🚲", "🛺", "🚆", "🛫", "🚇", "⛴", "🏎", "🚜", "🚍"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 8) { pairIndx in
            emojis[pairIndx]
        }
    }
    
    @Published private var model = createMemoryGame()
    
//    var objectWillChange: ObservableObjectPublisher
    
    
    var cards: [Card] {
        return model.cards
    }
    
    //MARK:- Intent(s)
    func choose(card: Card) {
//        objectWillChange.send()
        model.choose(card)
    }
}
