//
//  ContentView.swift
//  iOSCalculator
//
//  Created by Александр Толстой on 11.05.2020.
//  Copyright © 2020 Aleksandr Tolstoy. All rights reserved.
//

import SwiftUI

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

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

// Global Application State
class GlobalEnvironment: ObservableObject {
    
    @Published var display = ""
    var leftNumber: String = ""
    var operation: String = ""
    var rightNumber: String = ""

    let operations: [String] = ["×", "÷", "+", "-", "%"]
    let digits: [String] = ["0","1","2","3","4","5","6","7","8","9"]
    
    func clearHistory() {
        self.operation = ""
        self.rightNumber = ""
    }
    
    func receiveInput(calculatorButton: CalculatorButton) {
        
        let input = calculatorButton.title
        self.display += input
        
        if self.operation != "" {
            self.rightNumber += input
        } else {
            self.leftNumber += input
        }
        
        if operations.contains(input) {
            self.operation = input
        }
        
        if input == "=" {
            let leftNumber = (self.leftNumber as NSString).doubleValue
            let rightNumber = (self.rightNumber as NSString).doubleValue
                
            if operation == "×" {
                self.leftNumber = (leftNumber * rightNumber).string
            }
            else if operation == "÷" {
                self.leftNumber = (leftNumber / rightNumber).string
            }
            else if operation == "+" {
                self.leftNumber = (leftNumber + rightNumber).string
            }
            else if operation == "-" {
                self.leftNumber = (leftNumber - rightNumber).string
            }
            else if operation == "%" {
                self.leftNumber = (leftNumber * (rightNumber / 100)).string
            }

            self.clearHistory()
            self.display = self.leftNumber
        }

        else if input == "AC" {
            self.clearHistory()
            self.leftNumber = ""
            self.display = ""
        }

        else if input == "±" {
            let number = (self.leftNumber as NSString).doubleValue
            self.leftNumber = (number != 0 ? -number : 0).string

            self.clearHistory()
            self.display = self.leftNumber
        }
    }
}


struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
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
                    Text(env.display)
                    .font(.system(size: 64))
                    .foregroundColor(.white)
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self) {button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }) {
            Text(button.title)
            .font(.system(size: 32))
                .frame(width: self.buttonWidth(), height: self.buttonWidth())
            .foregroundColor(.white)
                .background(button.background)
                .cornerRadius(self.buttonWidth())
        }
    }
    
    private func buttonWidth() -> CGFloat{
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
