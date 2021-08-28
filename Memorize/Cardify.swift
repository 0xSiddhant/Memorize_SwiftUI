//
//  Cardify.swift
//  Memorize
//
//  Created by Siddhant Kumar on 28/08/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
         ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstant.cornerRadius)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: DrawingConstant.lineWidth)
                content
            } else {
                shape
                    .fill()
            }
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
