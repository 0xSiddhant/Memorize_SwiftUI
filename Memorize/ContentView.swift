//
//  ContentView.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card: card)
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
    @State var isFace: Bool = false
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
            }
        }
        .foregroundColor(.red)
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EmojiMemoryGame()
        ContentView(viewModel: model)
            .preferredColorScheme(.light)
        ContentView(viewModel: model)
            .preferredColorScheme(.dark)
    }
}
