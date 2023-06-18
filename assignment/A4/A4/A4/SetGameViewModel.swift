//
//  SetGameViewModel.swift
//  A3
//
//  Created by Leon Z on 2023-03-26.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    static private func createSetGame(deal: Bool) -> SetGameModel {
        SetGameModel(
            numsOfShapes: NumOfShapes.allCases.map{ $0.rawValue },
            shapes: CardShape.allCases.map{ $0.rawValue },
            shadings: Shading.allCases.map{ $0.rawValue },
            colors: CardColor.allCases.map{ $0.rawValue },
            deal: deal
        )
    }
    
    @Published private var model: SetGameModel = createSetGame(deal: false)
    
    var cards: [SetGameModel.Card] {
        return model.cards
    }
    
    var visibleCards: [SetGameModel.Card] {
        return model.cards.filter({ !$0.isInDeck && !$0.isDiscarded })
    }
    
    var isEnoughCardsInDeck: Bool {
        return model.cards.filter({ $0.isInDeck }).count >= 3
    }
    
    func select(_ card: SetGameModel.Card) {
        model.select(card)
    }
    
    func newGame() {
        model = SetGameViewModel.createSetGame(deal: true)
    }
    
    func cheat() {
        model.cheat()
    }
    
    func dealCards() {
        model.dealCards()
    }
    
    func getFrameColor(for card: SetGameModel.Card) -> Color {
        switch (card.isSelected, card.isMatched) {
        case (true, 1): return .green
        case (true, -1): return .red
        case (true, 0): return .orange
        default: return .blue
        }
    }
}

enum CardColor: String, CaseIterable {
    case red
    case green
    case purple
    
    var color: Color {
        switch self {
        case .red: return Color(red: 232/255, green: 54/255, blue: 132/255)
        case .green: return Color(red: 129/255, green: 214/255, blue: 113/255)
        case .purple: return Color(red: 143/255, green: 141/255, blue: 214/255)
        }
    }
}

enum NumOfShapes: Int, CaseIterable {
    case one = 1, two, three
}

enum CardShape: String, CaseIterable {
    case diamond
    case squiggle
    case oval
}

enum Shading: String, CaseIterable {
    case solid
    case striped
    case open
}
