//
//  Cardify.swift
//  A4
//
//  Created by Leon Z on 2023-06-13.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var frameColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let cardFrame = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            cardFrame.fill().foregroundColor(.white)
            cardFrame.stroke(frameColor, lineWidth: DrawingConstants.lineWidth)
            content
        }
//            .rotationEffect(Angle.degrees(card.isMatched == 1 ? 360 : 0)).animation(Animation.easeInOut(duration: 0.5))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(frameColor: Color) -> some View {
        return self.modifier(Cardify(frameColor: frameColor))
    }
}
