//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Leon Z on 2022-11-22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // let game means we will not change the pointer "game"
    // but we can change the class this "game" point to
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
