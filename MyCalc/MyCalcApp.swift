//
//  MyCalcApp.swift
//  MyCalc
//
//  Created by Dima on 06.09.2023.
//

import SwiftUI

@main
struct MyCalcApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
