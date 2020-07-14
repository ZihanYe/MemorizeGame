//
//  MainSectionView.swift
//  memorize
//
//  Created by ZihanYe on 12/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import SwiftUI

struct MainSectionView: View {
    let emojiGame = EmojiMemoryGame()
    let emojiCardFactory : (MemoryGame<String>.Card) -> CardView = {
        card in
        CardView(card: card, fontSize: {size in
        Font.system(size: min(size.width, size.height)*0.7)})
    }
    
    let wordGame = WordMemoryGame()
    let wordCardFactory : (MemoryGame<String>.Card) -> CardView = {
        card in
        CardView(card: card, cardColor: Color.blue)
    }
    
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Memorize Game")
                    .font(.largeTitle)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                NavigationLink (
                    destination : MemoryGameView<EmojiMemoryGame>(viewModel: self.emojiGame, cardViewFactory: emojiCardFactory),
                    tag: 1,
                    selection: $selection
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(Color.yellow).opacity(0.7)
                        GeometryReader { geometry in
                            Text("Emoji").font(Font.system(size: min(geometry.size.height, geometry.size.width)*0.3))
                        }
                    }.onTapGesture {
                        self.emojiGame.resetGame()
                        self.selection = 1
                        }
                }
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                NavigationLink (
                    destination : MemoryGameView<WordMemoryGame>(viewModel: self.wordGame, cardViewFactory: wordCardFactory),
                    tag: 2,
                    selection: $selection
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(Color.blue).opacity(0.5)
                        GeometryReader { geometry in
                            Text("Word").font(Font.system(size: min(geometry.size.height, geometry.size.width)*0.3))
                        }
                    }.onTapGesture {
                        self.wordGame.resetGame()
                        self.selection = 2
                        
                    }
                }
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            }.padding()}
    }
    
}

struct MainSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MainSectionView()
    }
}
