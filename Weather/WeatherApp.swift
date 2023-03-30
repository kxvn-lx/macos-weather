//
//  WeatherApp.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .background(Color(hex: "#05080D").edgesIgnoringSafeArea(.all))
                .foregroundColor(.accentColor)
        }
    }
}
