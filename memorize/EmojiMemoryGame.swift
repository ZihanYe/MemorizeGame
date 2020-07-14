//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by ZihanYe on 06/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import Foundation

class EmojiMemoryGame: DetailMemoryGame {
    var model: MemoryGame<String> = CreateMemoryGame()
    private static func CreateMemoryGame() -> MemoryGame<String> {
        let emojis : Array<String>  = ["👻", "🎃","🤡","🐣","🐶","🌻","👾","🤖","🦄","🐳","🧀","🍙","🍕","🍺"]
        var indices : Array<Int> = Array(0 ... emojis.count)
        var chosenItem : Array<String> = []
        for i in 0 ..< 5 {
            let chosen = Int.random(in: 0 ..< emojis.count-i)
            chosenItem.append(emojis[indices[chosen]])
            indices[chosen] = emojis.count - i - 1
        }
        return MemoryGame<String>(numPair: 5, contentFactory: {pairIndex in return chosenItem[pairIndex]})
    }
    
    func chooseCard(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        objectWillChange.send()
        model = EmojiMemoryGame.CreateMemoryGame()
    }
}
