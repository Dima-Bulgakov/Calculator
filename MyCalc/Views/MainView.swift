//
//  MainView.swift
//  MyCalc
//
//  Created by Dima on 07.09.2023.
//

import SwiftUI

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

// MARK: Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
