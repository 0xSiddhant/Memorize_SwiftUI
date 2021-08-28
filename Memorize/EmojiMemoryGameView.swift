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
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card: card)
                    }
            }
        }
        .foregroundColor(.red)
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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(DrawingConstant.circlePadding)
                        .opacity(DrawingConstant.circleOpacity)
                    Text(card.content)
                        .font(font(in: geomatry.size))
                
            }
            .cardify(isFaceUp: card.isFaceUp)
//            .modifier(Cardify(isFaceUp: card.isFaceUp))
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstant.fontScale)
    }
    
    private struct DrawingConstant {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: Double = 0.5
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EmojiMemoryGame()
        model.choose(card: model.cards.first!)
        return EmojiMemoryGameView(game: model)
    }
}
