//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

//MARK: ViewModel

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["✈️", "🚗", "🚌", "🚁","⛵️", "🛳", "🚄", "🚞", "🦼", "🚲", "🛺", "🚆", "🛫", "🚇", "⛴", "🏎", "🚜", "🚍"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 4) { pairIndx in
            emojis[pairIndx]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
//    var objectWillChange: ObservableObjectPublisher
    
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    //MARK:- Intent(s)
    func choose(card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card)
    }
}
