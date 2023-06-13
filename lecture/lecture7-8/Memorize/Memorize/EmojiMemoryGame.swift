//  ViewModel
//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Leon Z on 2023-02-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                                 "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                                 "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: Intent
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
