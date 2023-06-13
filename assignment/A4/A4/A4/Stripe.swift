//
//  Stripe.swift
//  A3
//
//  Created by Leon Z on 2023-03-27.
//

import SwiftUI

//struct Stripe<Content>: View where Content: Shape {
//    let numOfStrips: Int = 8
//    let lineWidth: CGFloat = 2
//
//    let shape: Content
//    let color: Color
//
//    var body: some View {
//        HStack {
//            ForEach(0..<numOfStrips, id: \.self) { index in
//                Color.white
//                color
//                if index == numOfStrips - 1 {
//                    Color.white
//                }
//            }
//        }.mask(shape)
//            .overlay(shape.stroke(color, lineWidth: 1.3))
//    }
//}

struct Stripe<Content>: View where Content: Shape {
    let numOfStripes: Int = 8
    let strokeLineWidth: CGFloat = 3
    
    let shape: Content
    let color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numOfStripes, id: \.self) { _ in
                Color.white
                color.frame(width: strokeLineWidth * 2/3)
            }
            Color.white
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: strokeLineWidth))
    }
}
