//
//  SetGameView.swift
//  A3
//
//  Created by Leon Z on 2023-03-24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    @Namespace private var dealingCard
    
    var body: some View {
        VStack {
            Text("Set Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            VStack {
                HStack {
                    deckBody
                    Spacer()
                    discardPile
                }
            }
            gameBody
            Spacer()
            VStack {
                HStack(spacing: 30) {
                    newGame
                    cheat
                }
            }
        }
        .padding()
    }
    
    private func zIndex(of card: SetGameModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: Array(game.visibleCards), aspectRatio: 2/3, minWidth: 80) { card in
            CardView(game: game, card: card).padding(4)
                .matchedGeometryEffect(id: card.id, in: dealingCard)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        game.select(card)
                    }
                }
        }
        .onAppear {
            withAnimation() {
                game.newGame();
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter { $0.isInDeck }) { card in
                CardView(game: game, card: card)
                    .zIndex(zIndex(of: card))
                    .matchedGeometryEffect(id: card.id, in: dealingCard)
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            withAnimation {
                if (game.isEnoughCardsInDeck) {
                    game.dealCards()
                }
            }
        }
    }
    
    var discardPile: some View {
        ZStack {
            ForEach(game.cards.filter { $0.isDiscarded }) { card in
                CardView(game: game, card: card)
                    .zIndex(zIndex(of: card))
                    .matchedGeometryEffect(id: card.id, in: dealingCard)
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
    }
    
    var newGame: some View {
        Button(action: { withAnimation { game.newGame() } }, label: {
            Text("New Game").font(.headline)
        })
    }
    
    var cheat: some View {
        Button(
            action: { withAnimation(.easeInOut(duration: 0.5)) { game.cheat() } },
            label: { Text("Cheat").font(.headline) }
        )
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3;
        static let deckHeight: CGFloat = 90;
        static let deckWidth: CGFloat = deckHeight * aspectRatio;
    }
}

struct CardView: View {
    var game: SetGameViewModel
    let card: SetGameModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(0..<card.numOfShapes, id: \.self) { _ in
                    drawShape(in: geometry)
                        .foregroundColor(CardColor(rawValue: card.color)?.color)
                        .frame(
                            width: geometry.size.width * 0.7,
                            height: geometry.size.height * 0.2
                        )
                        .padding(.vertical, geometry.size.height * 0.035)
                }
            }
            .cardify(frameColor: game.getFrameColor(for: card), isFaceUp: !card.isInDeck)
            .rotationEffect(Angle.degrees(card.isMatched == -1 ? 3 : 0))
            .rotationEffect(Angle.degrees(card.isMatched == 1 ? 360 : 0))
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
