//
//  CardView.swift
//  
//
//  Created by ZihanYe on 12/07/2020.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    var fontSize : ((CGSize) -> Font?)? = nil
    var rotation : Bool = true
    var cardColor : Color = Color.yellow
    
    var body: some View {
        GeometryReader ( content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    @State private var animatedBonusRemaining : Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining  = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
             ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
                            .onAppear(perform: {self.startBonusTimeAnimation()})
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90))
                    }
                }
                .padding(5).opacity(0.4)
                setText(for: Text(self.card.content), with: size)
                    //.font(Font.system(size: min(size.width, size.height)*0.7))
            }
             .cardify(isFaceUp: card.isFaceUp, with: cardColor)
             .foregroundColor(cardColor)
             .transition(AnyTransition.slide.combined(with: AnyTransition.scale))
        }
    }
    
    private func setText(for text: Text, with size: CGSize) -> some View {
        Group {
            if self.fontSize == nil {
                text.scaledToFit()
                    .rotationEffect(Angle.degrees(card.isMatched && self.rotation ? 360: 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            } else {
                text.font(self.fontSize!(size))
                .rotationEffect(Angle.degrees(card.isMatched && self.rotation ? 360: 0))
                .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
        }
       
    }
}
