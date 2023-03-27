//
//  SetGameView.swift
//  A3
//
//  Created by Leon Z on 2023-03-24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 10) {
                    ForEach(game.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
        }
        .padding()
    }
}

struct CardView: View {
    let card: SetGameModel.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(CardColor(rawValue: card.color)?.color)
            VStack {
                Text("\(card.numOfShapes)")
                Text("\(card.shape)")
                Text("\(card.shading)")
            }
        }
    }
}













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
