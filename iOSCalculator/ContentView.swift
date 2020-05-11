//
//  ContentView.swift
//  iOSCalculator
//
//  Created by Александр Толстой on 11.05.2020.
//  Copyright © 2020 Aleksandr Tolstoy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let buttons = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "F", "="]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack (spacing: 12) {
                HStack {
                    Spacer()
                    Text("0")
                    .font(.system(size: 64))
                    .foregroundColor(.white)
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self) {button in
                            Text(button)
                            .font(.system(size: 32))
                                .frame(width: self.buttonWidth(), height: self.buttonWidth())
                            .foregroundColor(.white)
                            .background(Color.orange)
                                .cornerRadius(self.buttonWidth())
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    func buttonWidth() -> CGFloat{
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
