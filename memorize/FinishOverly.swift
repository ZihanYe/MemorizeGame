//
//  FinishOverly.swift
//  memorize
//
//  Created by ZihanYe on 13/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import SwiftUI

struct FinishOverly: View {
    var score: Double
    var gameRestart : () -> Void
    
    var colorScheme : Color = Color.yellow
    
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Group {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4).fill(self.colorScheme)
                    VStack {
                        Text("Done!!!").font(.largeTitle)
                        Spacer()
                        Text("Score:\(Int(self.score))").font(.title)
                        Spacer()
                        Spacer()
                        Button(action: {
                            self.gameRestart()
                        }) {
                            Text("Restart")
                            .padding()
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .foregroundColor(.blue)
                            .background(Color.orange)
                            .cornerRadius(20)
                        }
                    }.padding().padding(.bottom, 20).padding(.top, 20).foregroundColor(Color.orange)
                }
            }.frame(width: geometry.size.width*0.7, height: geometry.size.height*0.5, alignment: .center)
        }
    }
}

struct FinishOverly_Previews: PreviewProvider {
    static var previews: some View {
        FinishOverly(score: 100, gameRestart: {}, colorScheme: Color.blue)
    }
}
