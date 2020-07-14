//
//  ContentView.swift
//  memorize
//
//  Created by ZihanYe on 05/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(items: viewModel.cards) { card in
                CardView(card: card, fontSize: {size in
                Font.system(size: min(size.width, size.height)*0.7)}, rotation: true)
                    .onTapGesture (perform: {
                        withAnimation(.linear(duration: 0.5)) {
                            self.viewModel.chooseCard(card: card)
                        }
                    }
                )
                .padding(5)
            }.padding()
            .foregroundColor(Color.orange)
            HStack {
                Text("Score: \(Int(viewModel.score))")
                .foregroundColor(Color.blue)
                .padding(.leading)
                    .font(.title)
                Spacer(minLength: 5)
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: {
                    Text("Restart")
                    .padding()
                    .foregroundColor(.blue)
                    .background(Color.yellow)
                    .cornerRadius(40)
                })
            }.padding(.leading)
                .padding(.trailing)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.chooseCard(card: game.cards[0])
        
        return EmojiMemoryGameView(viewModel: game)
    }
}
