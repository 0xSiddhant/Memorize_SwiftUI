//
//  Cardify.swift
//  Memorize
//
//  Created by Siddhant Kumar on 28/08/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    
    func body(content: Content) -> some View {
         ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstant.cornerRadius)
            if rotation < 90 {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: DrawingConstant.lineWidth)
            } else {
                shape
                    .fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
    } 
    
    private struct DrawingConstant {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
