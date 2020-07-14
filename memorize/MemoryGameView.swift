//
//  MemoryGameView.swift
//  memorize
//
//  Created by ZihanYe on 13/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import SwiftUI

struct MemoryGameView<ViewModel>: View where ViewModel : DetailMemoryGame {
    @ObservedObject var viewModel : ViewModel
    
    var cardViewFactory : (MemoryGame<String>.Card) -> CardView
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if !self.viewModel.finished {
                        Grid(items: viewModel.cards) { card in
                            self.cardViewFactory(card)
                                .onTapGesture (perform: {
                                    withAnimation(.linear(duration: 0.5)) {
                                        self.viewModel.chooseCard(card: card)
                                    }
                                }
                            )
                            .padding(5)
                        }.padding()
                    }
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
                    .opacity(self.viewModel.finished ? 0 : 1).animation(.linear)
                }
            }
            if self.viewModel.finished {
                GeometryReader {
                    geometry in
                    LottieView(filename: "confetti").offset(x: 0, y: -100).frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }.overlay(
            FinishOverly(score:self.viewModel.score, gameRestart: { self.viewModel.resetGame()}).offset(x: 0, y: self.viewModel.finished ? -50 : +600).animation(.linear(duration:2))
        )
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.chooseCard(card: game.cards[0])
        
        let emojiCardFactory : (MemoryGame<String>.Card) -> CardView = {
            card in
            CardView(card: card, fontSize: {size in
            Font.system(size: min(size.width, size.height)*0.7)}, rotation: true)
        }
        return MemoryGameView<EmojiMemoryGame>(viewModel: game, cardViewFactory: emojiCardFactory)
    }
}
