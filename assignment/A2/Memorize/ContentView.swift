//  View
//
//  ContentView.swift
//  Memorize
//
//  Created by Leon Z on 2022-11-22.
//

import SwiftUI

struct ContentView: View {
    // usually viewModel should be some name like Game
    // @ObservedObject here means if anything in this viewModel changed
    // then we rebuild the body
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
            Text(viewModel.chosenTheme.name)
                .font(.title2)
            Text("Score: \(viewModel.score)")
                
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.chosenColor)
            Spacer()
            Button(action: { viewModel.newGame() }, label: {
                VStack {
                    Image(systemName: "aqi.medium").font(.largeTitle)
                    Text("New Game").font(.caption)
                }
            })
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
