//  Model
//
//  MemoryGame.swift
//  Memorize
//
//  Created by Leon Z on 2023-02-07.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) means other class can see the fields but cannot change it
    private(set) var cards: Array<Card>
    private(set) var chosenTheme: Theme
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        // , means && but allow you have let in the code
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // should say: MemoryGame<CardContent> where CardContent: Equatable
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    score -= cards[chosenIndex].isAlreadySeen ? 1 : 0
                    score -= cards[potentialMatchIndex].isAlreadySeen ? 1 : 0
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
                cards[chosenIndex].isAlreadySeen = true
                cards[potentialMatchIndex].isAlreadySeen = true
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(chosenTheme: Theme, createCardContent: (Int, [CardContent]) -> CardContent?) {
        self.chosenTheme = chosenTheme
        cards = Array<Card>();
        // add numberOfPairsOfCards x 2 cards to cards array
        let randomEmojis = chosenTheme.emojis.shuffled()
        for pairIndex in 0..<chosenTheme.numPairs {
            if let content = createCardContent(pairIndex, randomEmojis) {
                cards.append(Card(content: content, id: pairIndex * 2))
                cards.append(Card(content: content, id: pairIndex * 2 + 1))
            }
        }
        cards.shuffle()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isAlreadySeen: Bool = false
        let content: CardContent
        let id: Int
    }
    
    struct Theme {
        let name: String
        let emojis: [CardContent]
        var numPairs: Int
        let color: String
    }
}
