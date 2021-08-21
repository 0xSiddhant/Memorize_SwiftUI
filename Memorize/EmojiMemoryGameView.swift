//
//  ContentView.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach(game.cards) { card in
                            CardView(card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    game.choose(card: card)
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}


struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geomatry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstant.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstant.lineWidth)
                    Text(card.content)
                        .font(font(in: geomatry.size))
                } else if card.isMatched {
                    shape
                        .opacity(0)
                } else {
                    shape
                        .fill()
                }
            }
            .foregroundColor(.red)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstant.fontScale)
    }
    
    private struct DrawingConstant {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EmojiMemoryGame()
        EmojiMemoryGameView(game: model)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: model)
            .preferredColorScheme(.dark)
    }
}
