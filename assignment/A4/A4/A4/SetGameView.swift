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
            Text("Set Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            AspectVGrid(items: Array(game.visibleCards), aspectRatio: 2/3, minWidth: 80) { card in
                CardView(card: card).padding(4)
                    .onTapGesture {
                        game.select(card)
                    }
            }
            Spacer()
            HStack(spacing: 30) {
                Button(action: { game.newGame() }, label: {
                    Text("New Game").font(.headline)
                })
                Button(action: { game.cheat() }, label: {
                    Text("Cheat").font(.headline)
                })
                Button(action: { game.dealCards() }, label: {
                    Text("Deal 3 More Cards").font(.headline)
                }).disabled(!game.isEnoughCardsInDeck)
            }
        }
        .padding()
    }
}

struct CardView: View {
    let card: SetGameModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardFrame = RoundedRectangle(cornerRadius: 20)
                // add fill make sure selecting the black background can select the card
                cardFrame.fill().foregroundColor(.white)
                // When you call strokeBorder() with a color parameter like Color.blue,
                // SwiftUI implicitly adds a foregroundColor() modifier to the view hierarchy for you.
                switch (card.isSelected, card.isMatched) {
                case (true, 1): cardFrame.stroke(.green, lineWidth: 3)
                case (true, -1): cardFrame.stroke(.red, lineWidth: 3)
                case (true, 0): cardFrame.stroke(.orange, lineWidth: 3)
                default: cardFrame.stroke(.blue, lineWidth: 3)
                }
                VStack(spacing: 0) {
                    Spacer()
                    ForEach(0..<card.numOfShapes, id: \.self) { _ in
                        drawShape(in: geometry)
                            .foregroundColor(CardColor(rawValue: card.color)?.color)
                            .frame(
                                width: geometry.size.width * 0.7,
                                height: geometry.size.height * 0.2
                            )
                            .padding(.vertical, geometry.size.height * 0.035)
                    }
                    Spacer()
                }
                VStack {
//                    Text("\(card.numOfShapes)")
//                    Text("\(card.shape)")
//                    Text("\(card.shading)")
                }
            }
        }
    }
    
    @ViewBuilder
    private func drawShape(in geometry: GeometryProxy) -> some View {
        switch Shading(rawValue: card.shading)! {
        case .solid: CardComponent(shape: CardShape(rawValue: card.shape)!)
                .fill()
        case .open: CardComponent(shape: CardShape(rawValue: card.shape)!)
                .stroke(lineWidth: 3)
        case .striped: Stripe(shape: CardComponent(shape: CardShape(rawValue: card.shape)!), color: CardColor(rawValue: card.color)?.color ?? Color.red)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
