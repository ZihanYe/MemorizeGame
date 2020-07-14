//
//  Cardify.swift
//  memorize
//
//  Created by ZihanYe on 09/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import SwiftUI

struct Cardify : AnimatableModifier  {
    var rotation: Double
    var cardColor: Color
    
    init(isFaceUp: Bool, with color: Color) {
        rotation = isFaceUp ? 0 : 180
        cardColor = color
    }
    var isFaceUp : Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get {
            return rotation
        }
        set {
            rotation = newValue
        }
    }
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 10.0).fill(cardColor)
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, with color: Color) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, with: color))
    }
}
