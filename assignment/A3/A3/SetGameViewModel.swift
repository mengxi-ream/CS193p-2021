//
//  SetGameViewModel.swift
//  A3
//
//  Created by Leon Z on 2023-03-26.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    
    static private func createSetGame() -> SetGameModel {
        SetGameModel(
            numsOfShapes: NumOfShapes.allCases.map{ $0.rawValue },
            shapes: Shape.allCases.map{ $0.rawValue },
            shadings: Shading.allCases.map{ $0.rawValue },
            colors: CardColor.allCases.map{ $0.rawValue }
        )
    }
    
    @Published private var model: SetGameModel = createSetGame()
    
    var cards: [SetGameModel.Card] {
        return model.cards
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

enum Shape: String, CaseIterable {
    case diamond
    case squiggle
    case oval
}

enum Shading: String, CaseIterable {
    case solid
    case striped
    case open
}
