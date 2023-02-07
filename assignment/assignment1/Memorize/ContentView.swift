//
//  ContentView.swift
//  Memorize
//
//  Created by Leon Z on 2022-11-22.
//

import SwiftUI

struct ContentView: View {
    let vehicleEmojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                          "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                          "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
        
    var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    
    var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚",
                      "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    
    @State var emojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                         "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                         "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    @State var emojiCount = 6

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
                
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 10) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                car
                Spacer()
                animal
                Spacer()
                food
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    var car: some View {
        Button(action: {
            emojis = vehicleEmojis.shuffled()
            emojiCount = Int.random(in: 8...emojis.count)
        }, label: {
            VStack {
                Image(systemName: "car").font(.largeTitle)
                Text("Vehichles")
                    .font(.caption)
            }
        })
    }

    var animal: some View {
        Button {
            emojis = animalEmojis.shuffled()
            emojiCount = Int.random(in: 8...emojis.count)
        } label: {
            VStack {
                Image(systemName: "hare")
                Text("Animal")
                    .font(.caption)
            }
        }
    }
    
    var food: some View {
        Button {
            emojis = foodEmojis.shuffled()
            emojiCount = Int.random(in: 8...emojis.count)
        } label: {
            VStack {
                Image(systemName: "carrot")
                Text("Food")
                    .font(.caption)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
