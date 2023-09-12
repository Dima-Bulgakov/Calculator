//
//  Extension.swift
//  MyCalc
//
//  Created by Dima on 07.09.2023.
//

import SwiftUI

// MARK: Extension: add my color to Color
extension Color {
    static let backgroundCalc = Color("backgroundCalc")
    static let darkGrayCalc = Color("darkGrayCalc")
    static let grayCalc = Color("grayCalc")
    static let orangeCalc = Color("orangeCalc")
}

// MARK: Extension: Button to Operation
extension Buttons {
    func toOperation() -> Operation {
        switch self {
        case .plus:
            return .addition
        case .minus:
            return .subtract
        case .multiple:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
}
