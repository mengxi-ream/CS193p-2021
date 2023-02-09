//  ViewModel
//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Leon Z on 2023-02-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                         "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                         "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        // objectWillChange.send()
        // don't need to do the above code because we make model @Published
        // then every time we change model, we will call objectWillChange.send()
        model.choose(card)
    }
}
