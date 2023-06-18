//
//  SetGameModel.swift
//  A3
//
//  Created by Leon Z on 2023-03-26.
//

import Foundation

struct SetGameModel {
    private(set) var cards: Array<Card>
    
    init(numsOfShapes: [Int], shapes: [String], shadings: [String], colors: [String], deal: Bool) {
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
        
        cards.shuffle();
        if (deal) {
            for idx in 0..<12 {
                cards[idx].isInDeck = false
            }
        }
    }
    
    mutating func select(_ card: Card) {
        if let chosenId = cards.firstIndex(where: { $0.id == card.id }) {
            var selectedIds = cards.allIndices(where: { $0.isSelected })
            if selectedIds.count <= 1 {
                cards[chosenId].isSelected.toggle()
            } else if selectedIds.count == 2 {
                cards[chosenId].isSelected.toggle()
                if !selectedIds.contains(chosenId) {
                    selectedIds.append(chosenId);
                    if isSet(selectedIds.map { cards[$0] }) {
                        selectedIds.forEach { cards[$0].isMatched = 1 }
                    } else {
                        selectedIds.forEach { cards[$0].isMatched = -1 }
                    }
                }
            } else if selectedIds.count == 3 {
                if cards[selectedIds[0]].isMatched == -1 {
                    selectedIds.forEach {
                        cards[$0].isMatched = 0
                    }
                    selectedIds.forEach {
                        cards[$0].isSelected.toggle()
                    }
                    cards[chosenId].isSelected.toggle()
                }
                if (cards[selectedIds[0]].isMatched == 1) {
                    selectedIds.forEach {
                        cards[$0].isSelected.toggle()
                        cards[$0].isDiscarded.toggle()
                    }
                    cards[chosenId].isSelected.toggle()
//                    let inDeckIds = cards.allIndices(where: { $0.isInDeck })
//                    replaceCards(from: inDeckIds, to: selectedIds)
                }
            }
        }
    }
    
    // bug
    mutating func cheat() {
        let selectedIds = cards.allIndices(where: { $0.isSelected })
        let inDeckIds = cards.allIndices(where: { $0.isInDeck })
        if isSet(selectedIds.map { cards[$0] }) {
            replaceCards(from: inDeckIds, to: selectedIds)
        } else {
            selectedIds.forEach {
                cards[$0].isSelected.toggle()
                cards[$0].isMatched = 0
            }
        }
        let visibleIds = cards.allIndices(where: { !$0.isInDeck && !$0.isDiscarded })
        for i in 0..<visibleIds.count-2 {
            for j in i+1..<visibleIds.count - 1 {
                for k in j+1..<visibleIds.count {
                    let visibleCardIndices = [visibleIds[i], visibleIds[j], visibleIds[k]]
                    if isSet(visibleCardIndices.map { cards[$0] }) {
                        visibleCardIndices.shuffled().prefix(2).forEach {
                            cards[$0].isSelected = true
                        }
                        return
                    }
                }
            }
        }
    }
    
    // bug
    mutating func dealCards() {
        let selectedIds = cards.allIndices(where: { $0.isSelected })
        let inDeckIds = cards.allIndices(where: { $0.isInDeck })
        if isSet(selectedIds.map { cards[$0] }) {
            replaceCards(from: inDeckIds, to: selectedIds)
        } else if (inDeckIds.count >= 3) {
            inDeckIds.prefix(3).forEach {
                cards[$0].isInDeck.toggle()
            }
        }
    }
    
    private func isSet(_ selectedCards: [Card]) -> Bool {
        if selectedCards.count != 3 { return false }
        return (
            selectedCards.map({ $0.numOfShapes }).isAllSameOrDiff &&
            selectedCards.map({ $0.shape }).isAllSameOrDiff &&
            selectedCards.map({ $0.shading }).isAllSameOrDiff &&
            selectedCards.map({ $0.color }).isAllSameOrDiff
        )
    }
    
    mutating private func replaceCards(from inDeckIds: [Int], to selectedIds: [Int]) {
        let numOfReplacement = selectedIds.count
        if inDeckIds.count >= numOfReplacement {
            for idx in 0..<numOfReplacement {
                cards[selectedIds[idx]].isDiscarded.toggle()
                cards[selectedIds[idx]].isSelected.toggle()
                let temp = cards[selectedIds[idx]]
                cards[selectedIds[idx]] = cards[inDeckIds.last! - numOfReplacement + 1 + idx]
                cards[inDeckIds.last! - numOfReplacement + 1 + idx] = temp
                cards[selectedIds[idx]].isInDeck.toggle()
            }
        }
    }
    
    struct Card: Identifiable {
        let numOfShapes: Int
        let shape: String
        let shading: String
        let color: String
        let id: Int
        
        var isSelected = false
        var isMatched: Int = 0
        var isDiscarded = false
        var isInDeck = true
    }
}

extension Array where Element: Equatable & Hashable {
    var isAllSame: Bool {
        guard let first = self.first else {
            return false
        }
        return allSatisfy { $0 == first }
    }
    
    var isAllDiff: Bool {
        guard count > 0 else {
            return false
        }
        return Set(self).count == count
    }
    
    var isAllSameOrDiff: Bool {
        return isAllSame || isAllDiff
    }
}

extension Array {
    func allIndices(where predicate: (Self.Element) -> Bool) -> [Self.Index] {
        return indices.filter { predicate(self[$0]) }
    }
}
