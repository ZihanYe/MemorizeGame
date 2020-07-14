//
//  WordMemoryGame.swift
//  memorize
//
//  Created by ZihanYe on 12/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import Foundation

class WordMemoryGame: DetailMemoryGame {
    var model: MemoryGame<String> = CreateMemoryGame()
    
    private static func CreateMemoryGame() -> MemoryGame<String> {
        let words : Array<String>  = GetRandomWords(num: 4)
        return MemoryGame<String>(numPair: words.count, contentFactory: {pairIndex in return words[pairIndex]})
    }
    
    private static func GetRandomWords(num: Int) -> Array<String> {
        var words : Array<String> = []
        if let wordsFilePath = Bundle.main.path(forResource: "words", ofType: nil) {
            do {
                let wordsString = try String(contentsOfFile: wordsFilePath)
                let wordLines = wordsString.components(separatedBy: .newlines)
                for _ in 0 ..< num {
                    let randomLine = wordLines[numericCast(arc4random_uniform(numericCast(wordLines.count)))]
                    words.append(randomLine)
                }
            } catch { // contentsOfFile throws an error
                print("Error: \(error)")
            }
        }
        return words
    }
    
    func chooseCard(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        objectWillChange.send()
        model = WordMemoryGame.CreateMemoryGame()
    }
}
