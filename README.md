# Calculator
Simple iOS Calculator


## Major Functionality

- SwiftUI

- MVVM


## Screenshots
<!--
-->
</p>

<img src="https://github.com/Dima-Bulgakov/Calculator/assets/111886499/0d5a34f2-4130-46c6-bf9a-9e3833afc510" width="300" />

## Tools

[![MIT License](https://img.shields.io/badge/-Swift-orange)](https://developer.apple.com/swift/)
[![AGPL License](https://img.shields.io/badge/-iOS-black)](https://www.apple.com/ios/ios-16/)
[![AGPL License](https://img.shields.io/badge/-SwiftUI-Green)](https://www.apple.com/ios/ios-16/)
[![AGPL License](https://img.shields.io/badge/-MVVM-Blue)](https://www.apple.com/ios/ios-16/)



## Usage/Examples

```swift
import SwiftUI

#View ----------------------------------------------

struct MainView: View {
    
    // MARK: Property
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            
            // MARK: Background
            Color.backgroundCalc
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                // MARK: Display
                HStack {
                    Spacer()
                    Text(viewModel.value)
                        .foregroundColor(.white)
                        .font(.system(size: 90, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .padding(.horizontal, 28)
                }
                
                // MARK: Buttons
                ForEach(viewModel.buttonsArray, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.didTap(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: viewModel.buttonWidth(item: item),
                                        height: viewModel.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(item.buttonFontColor)
                                    .cornerRadius(viewModel.buttonHeight() / 2)
                                    .font(.system(size: 35))
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

#ViewModel ----------------------------------------------

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

#Model ----------------------------------------------

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

#Extensions ----------------------------------------------

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

```

## Thank You!
