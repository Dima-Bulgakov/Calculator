//
//  Model.swift
//  MyCalc
//
//  Created by Dima on 07.09.2023.
//

import SwiftUI

// MARK: Operation Enum
enum Operation {
    case addition, subtract, multiply, divide, negative, percent, decimal, none
}

// MARK: Buttons Enum
enum Buttons: String {
    case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case plus = "+", minus = "-", multiple = "×", divide = "÷", equal = "=", decimal = ".", percent = "%", negative = "+/-", clear = "AC"
    
    // MARK: Color Change Properties
    var buttonColor: Color {
        switch self {
        case .clear, .negative, .percent: return Color.grayCalc
        case .divide, .multiple, .minus, .plus, .equal: return Color.orangeCalc
        default: return Color.darkGrayCalc
        }
    }
    
    var buttonFontColor: Color {
        switch self {
        case .clear, .negative, .percent: return Color.backgroundCalc
        default: return Color.white
        }
    }
}
