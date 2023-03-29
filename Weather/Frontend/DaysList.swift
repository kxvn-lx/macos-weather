//
//  DaysList.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import SwiftUI

struct DaysList: View {
    var weatherResponse: WeatherResponse?
    
    var body: some View {
         if let weather = weatherResponse {
             ForEach(weather.days.dropFirst(), id: \.datetime) { day in
                 HStack(alignment: .firstTextBaseline) {
                     VStack(alignment: .leading) {
                         Text(day.description)
                         Text("\(day.temp, specifier: "%.1f") celcius")
                     }
                     
                     Spacer()
                     
                     VStack(alignment: .trailing) {
                         Text("\(Date().getReadable(from: day.datetime).components(separatedBy: ", ")[0]),")
                         Text(Date().getReadable(from: day.datetime).components(separatedBy: ", ")[1])
                     }
                 }
                 
                 Divider()
                     .background(Color.gray.opacity(0.75))
             }
         } else {
             Text("No weather data available")
         }
     }
 }


