//
//  SetGameModel.swift
//  A3
//
//  Created by Leon Z on 2023-03-26.
//

import Foundation

struct SetGameModel {
    private(set) var cards: Array<Card>
    
    init(numsOfShapes: [Int], shapes: [String], shadings: [String], colors: [String]) {
        cards = []
        var cardId = 0
        for numOfShape in numsOfShapes {
            for shape in shapes {
                for shading in shadings {
                    for color in colors {
                        cards.append(Card(
                            numOfShapes: numOfShape,
                            shape: shape,
                            shading: shading,
                            color: color,
                            id: cardId
                        ))
                        cardId += 1
                    }
                }
            }
        }
    }
    
    struct Card: Identifiable {
        let numOfShapes: Int
        let shape: String
        let shading: String
        let color: String
        let id: Int
    }
}
