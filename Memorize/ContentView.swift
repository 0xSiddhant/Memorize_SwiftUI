//
//  ContentView.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = ["✈️", "🚗", "🚌", "🚁","⛵️", "🛳", "🚄", "🚞", "🦼", "🚲", "🛺", "🚆", "🛫", "🚇", "⛴", "🏎", "🚜", "🚍"]
    
    @State var counter = 4
    
    var body: some View {
        VStack {
            HStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach(emojis[0..<counter], id: \.self) { emoji in
                            CardView(content: emoji)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
            }
            Spacer()
            HStack {
                remove
                Spacer()
                Text("Setting")
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    var remove: some View {
        Button {
            if counter > 1 {
                counter -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if counter < emojis.count - 1 {
                counter += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}


struct CardView: View {
    @State var isFace: Bool = false
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            if isFace {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
            }
        }
        .foregroundColor(.red)
        .onTapGesture {
            isFace = !isFace
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
