//
//  ContentView.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    @State private var searchText = ""
    @State private var isHidden = true
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Button("") {
                    isHidden.toggle()
                }
                .opacity(0)
                .keyboardShortcut("f")
                Text(Date().getToday())
                SearchBarView(searchText: $searchText, isHidden: $isHidden)
            }
            
            Section(">> Today's weather for: \(vm.location)") {
                TodayView(weatherResponse: vm.weatherData)
            }
            
            Section(">> Upcoming") {
                DaysList(weatherResponse: vm.weatherData)
            }
        }
        .listStyle(.sidebar)
        .background(Color(hex: "#05080D").edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
