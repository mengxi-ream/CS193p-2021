//  ViewModel
//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Leon Z on 2023-02-07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias gameTheme = MemoryGame<String>.Theme
    
    static let vehicleEmojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                                "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                                "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    static let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    static let foodEmojis = ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"]
    static let flagEmojis = ["🏳️‍🌈", "🏳️‍⚧️", "🇨🇦", "🇨🇳", "🇭🇰", "🇰🇷", "🇺🇸"]
    static let heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
    static let ballEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"]
    
    static private func createMemoryGame(_ theme: gameTheme) -> MemoryGame<String> {
        MemoryGame<String>(chosenTheme: theme) { pairIndex, emojis in
            pairIndex >= emojis.count ? nil : emojis[pairIndex]
        }
    }
    
    static private let themes: [gameTheme] = {
        var themes = [gameTheme]()
        let defaultNumPairs = 7
        // themes.append(gameTheme(name: "VEHICLE", emojis: vehicleEmojis, numPairs: defaultNumPairs, color: "red"))
        themes.append(gameTheme(name: "VEHICLE", emojis: vehicleEmojis, numPairs: defaultNumPairs, color: Color.red.rawValue))
        themes.append(gameTheme(name: "ANIMAL", emojis: animalEmojis, numPairs: defaultNumPairs, color: Color.orange.rawValue))
        themes.append(gameTheme(name: "FOOD", emojis: foodEmojis, numPairs: defaultNumPairs, color: Color.yellow.rawValue))
        themes.append(gameTheme(name: "FLAG", emojis: flagEmojis, numPairs: defaultNumPairs, color: Color.green.rawValue))
        themes.append(gameTheme(name: "HEART", emojis: heartEmojis, numPairs: defaultNumPairs, color: Color.blue.rawValue))
        themes.append(gameTheme(name: "BALL", emojis: ballEmojis, numPairs: defaultNumPairs, color: Color.purple.rawValue))
        return themes
    }()
    
    @Published private var model: MemoryGame<String> = createMemoryGame(themes.randomElement()!)
    
    // chosenColor is a read-only properties, do not need private(set)
    var chosenColor: Color {
        return Color(rawValue: model.chosenTheme.color) ?? .red
//        switch model.chosenTheme.color {
//        case "red": return .red
//        case "orange": return .orange
//        case "yellow": return .yellow
//        case "green": return .green
//        case "blue": return .blue
//        case "purple": return .purple
//        default: return .red
//        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var chosenTheme: gameTheme {
        return model.chosenTheme
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        // objectWillChange.send()
        // don't need to do the above code because we make model @Published
        // then every time we change model, we will call objectWillChange.send()
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.themes.randomElement()!)
    }
}

// give color rawValue as string
extension Color : RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
            switch rawValue {
            case "red": self = .red
            case "orange": self = .orange
            case "yellow": self = .yellow
            case "green": self = .green
            case "blue": self = .blue
            case "purple": self = .purple
            default: return nil
            }
        }

    public var rawValue: RawValue {
        return self.description
    }
}

