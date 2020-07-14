//
//  DetailMemoryGame.swift
//  memorize
//
//  Created by ZihanYe on 13/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import Foundation

protocol DetailMemoryGame: ObservableObject {
    var model: MemoryGame<String> {get set}
    // MARK: access to the model
    var cards: Array<MemoryGame<String>.Card> {get}
    
    var score: Double {get}
    
    var finished : Bool { get }
    
    // MARK: intents
    func chooseCard(card: MemoryGame<String>.Card)
    
    func resetGame()
}

extension DetailMemoryGame {
    var cards: Array<MemoryGame<String>.Card> {
        get {model.cards}
    }
    
    var score: Double {
        get {model.score}
    }
    
    var finished : Bool {
        get {model.finished}
    }
}
