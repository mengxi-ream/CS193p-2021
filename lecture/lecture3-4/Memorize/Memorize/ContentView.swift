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
            .foregroundColor(.red)
            Spacer()
//            HStack {
//                Spacer()
//                car
//                Spacer()
//                animal
//                Spacer()
//                food
//                Spacer()
//            }
//            .font(.largeTitle)
//            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

//    var car: some View {
//        Button(action: {
//            emojis = vehicleEmojis.shuffled()
//            emojiCount = Int.random(in: 8...emojis.count)
//        }, label: {
//            VStack {
//                Image(systemName: "car").font(.largeTitle)
//                Text("Vehichles")
//                    .font(.caption)
//            }
//        })
//    }
//
//    var animal: some View {
//        Button {
//            emojis = animalEmojis.shuffled()
//            emojiCount = Int.random(in: 8...emojis.count)
//        } label: {
//            VStack {
//                Image(systemName: "hare")
//                Text("Animal")
//                    .font(.caption)
//            }
//        }
//    }
//
//    var food: some View {
//        Button {
//            emojis = foodEmojis.shuffled()
//            emojiCount = Int.random(in: 8...emojis.count)
//        } label: {
//            VStack {
//                Image(systemName: "carrot")
//                Text("Food")
//                    .font(.caption)
//            }
//        }
//    }
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
