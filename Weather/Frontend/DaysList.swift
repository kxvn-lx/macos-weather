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
                        HStack {
                            Text("\(day.temp, specifier: "%.1f") celcius")
                                .font(.system(.body, design: .monospaced))
                            
                            HStack {
                                Text("\(day.tempmax, specifier: "%.1f")c")
                                    .font(.system(.caption2, design: .monospaced))
                                Text("\(day.tempmin, specifier: "%.1f")c")
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            .opacity(0.5)
                        }
                        
                        HStack {
                            Text("Precip: \(day.precip, specifier: "%.1f")")
                                .font(.system(.body, design: .monospaced))
                            
                            HStack {
                                Text("\(day.precipprob, specifier: "%.1f")")
                                    .font(.system(.body, design: .monospaced))
                                Text("\(day.precipcover, specifier: "%.1f")")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        
                        Text(day.description)
                            .lineLimit(nil)
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
