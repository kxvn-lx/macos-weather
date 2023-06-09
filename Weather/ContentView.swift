//
//  ContentView.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    private var searchedLocation: String {
        guard let wd = vm.weatherData else { return "Melbourne" } // DEFAULT
        return wd.address.capitalized
    }
        
        var body: some View {
            List {
                SearchBarView()
                    .environmentObject(vm)
                
                Section(">> Today's weather for: \(searchedLocation)") {
                    if vm.weatherData != nil {
                        TodayView(weatherResponse: vm.weatherData!)
                    } else {
                        Text("No weather data available")
                    }
                }
                
                Section(">> Upcoming") {
                    DaysList(weatherResponse: vm.weatherData)
                }
            }
            .listStyle(.sidebar)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
