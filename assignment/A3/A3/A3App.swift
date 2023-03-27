//
//  A3App.swift
//  A3
//
//  Created by Leon Z on 2023-03-24.
//

import SwiftUI

@main
struct A3App: App {
    let game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
