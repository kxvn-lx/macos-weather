//
//  TodayView.swift
//  Weather
//
//  Created by Kevin Laminto on 29/3/2023.
//

import SwiftUI

struct TodayView: View {
    let day: Day?
    
    init(weatherResponse: WeatherResponse?) {
        self.day = weatherResponse?.days.first
    }
    
    
    var body: some View {
        if let day = day {
            VStack(alignment: .leading) {
                Text(day.conditions.rawValue)
                Text("\(day.temp, specifier: "%.1f") celcius")
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(day.hours, id: \.datetime) { hour in
                            VStack(alignment: .leading) {
                                Text(hour.datetime.prefix(5))
                                Text("\(hour.temp, specifier: "%.1f")")
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
        } else {
            Text("No weather data available")
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(weatherResponse: nil)
    }
}
