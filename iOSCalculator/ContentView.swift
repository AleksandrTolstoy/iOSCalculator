//
//  ContentView.swift
//  iOSCalculator
//
//  Created by Александр Толстой on 11.05.2020.
//  Copyright © 2020 Aleksandr Tolstoy. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    case ac, reverseSign, percent, factorise
    case equals, plus, minus, multiply, divide
    case zero, one, two, three, four, five, six, seven, eight, nine, dot

    var title: String {
        switch self {
        case .reverseSign: return "±"
        case .percent: return "%"
        case .factorise: return "F"
            
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        
        case .dot: return "."
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        default: return "AC"
        }
    }

    
    var background: Color {
        switch self {
        case .ac, .reverseSign, .percent, .factorise:
            return Color(.lightGray)
        case .equals, .plus, .minus, .multiply, .divide:
            return Color(.orange)
        default:
            return Color(.darkGray)
        }
    }
}

struct ContentView: View {
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .reverseSign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .factorise, .equals]
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
                            Button(action: {
                                
                            }) {
                                Text(button.title)
                                .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(), height: self.buttonWidth())
                                .foregroundColor(.white)
                                    .background(button.background)
                                    .cornerRadius(self.buttonWidth())
                            }
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
