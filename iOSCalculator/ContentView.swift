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
        VStack {
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) {button in
                        Text(button)
                        .font(.system(size: 32))
                        .frame(width: 80, height: 80)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
