//
//  ViewModel.swift
//  MyCalc
//
//  Created by Dima on 07.09.2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var value = "0"
    @Published var num: Double = 0.0
    @Published var currentOperation: Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: - Methods
    
    // MARK: Tap Button Method
    func didTap(button: Buttons) {
        switch button {
        case .plus, .minus, .multiple, .divide:
            currentOperation = button.toOperation()
            num = Double(value) ?? 0
            value = "0"
        case .equal:
            if let currentValue = Double(value) {
                value = formatResult(performOperation(currentValue))
            }
        case .percent:
            if let currentValue = Double(value) {
                value = formatResult(currentValue / 100.0)
            }
        case .clear:
            value = "0"
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .negative:
            if let negativeValue = Double(value) {
                value = formatResult(-negativeValue)
            }
        default:
            if value == "0" {
                value = String(button.rawValue)
            } else {
                value += String(button.rawValue)
            }
        }
    }

    // MARK: Helper Culculate Method
    func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return num + currentValue
        case .subtract:
            return num - currentValue
        case .multiply:
            return num * currentValue
        case .divide:
            return num / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: Remove Last "0" Method
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    // MARK: Size of Buttons Methods
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12.0
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero {
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
        return (screenWidth - totalSpacing) / totalColumns
    }

    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12.0
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColumns
    }
}
