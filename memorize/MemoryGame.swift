//
//  MemoryGame.swift
//  memorize
//
//  Created by ZihanYe on 05/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Double
    private var matchedCard : Int = 0
    private(set) var finished: Bool = false
    
    private var indexOfFaceUpCard : Int? {
        get {
            let faceup = cards.indices.filter { (index) -> Bool in
                cards[index].isFaceUp
            }
            return faceup.only
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialCard = indexOfFaceUpCard {
                if cards[potentialCard].content == cards[chosenIndex].content {
                    cards[potentialCard].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score = score + cards[potentialCard].bonusRemaining * 100
                    score = score + cards[chosenIndex].bonusRemaining * 100
                    matchedCard += 2
                    if matchedCard == cards.count {
                        finished = true
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
                // self.cards[potentialCard].isFaceUp = false
            } else {
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numPair: Int, contentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in (0 ..< numPair) {
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2+1))
        }
        cards.shuffle()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        var bonusTimeLimit : TimeInterval = 6
        private var faceupTime : TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        var bonusTimeRemaining : TimeInterval {
            max(0, bonusTimeLimit - faceupTime)
        }
        var bonusRemaining : Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit  : 0
        }
        
        var hasEarnedBonus : Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime : Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceupTime
            self.lastFaceUpDate = nil
        }
    }
    
}
