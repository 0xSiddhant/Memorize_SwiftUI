//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

//MARK:- ViewModel

class EmojiMemoryGame {
    static let emojis = ["✈️", "🚗", "🚌", "🚁","⛵️", "🛳", "🚄", "🚞", "🦼", "🚲", "🛺", "🚆", "🛫", "🚇", "⛴", "🏎", "🚜", "🚍"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 4) { pairIndx in
            emojis[pairIndx]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
