//
//  TodayView.swift
//  Weather
//
//  Created by Kevin Laminto on 29/3/2023.
//

import SwiftUI

struct TodayView: View {
    private let day: Day
    private var currentTime: String {
        // Get current time for live view
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        let timezoneOffset = weatherResponse.tzoffset * 60 * 60
        let timeZone = TimeZone(secondsFromGMT: timezoneOffset)!
        formatter.timeZone = timeZone
        
        return formatter.string(from: Date())
    }
    private let weatherResponse: WeatherResponse
    
    
    init(weatherResponse: WeatherResponse) {
        self.day = weatherResponse.days.first!
        self.weatherResponse = weatherResponse
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            VStack(alignment: .leading) {
                Text("\(day.getCurrentTemp(from: currentTime), specifier: "%.1f") celcius")
                    .font(.system(.largeTitle, design: .monospaced))
                Text(weatherResponse.description)
                    .lineLimit(nil)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(day.description)
                    .lineLimit(nil)
                
                ScrollViewReader { value in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(day.hours, id: \.datetime) { hour in
                                VStack(alignment: .leading) {
                                    Text(hour.datetime.prefix(2))
                                    Text("\(hour.temp, specifier: "%.1f")")
                                }
                                .font(.system(.body, design: .monospaced))
                                .id(hour.datetime)
                                .padding(.vertical, 3.5)
                                .padding(.horizontal, 2.5)
                                .overlay( /// apply a rounded border
                                    getRoundedBorderOverlay(hour: hour)
                                )
                            }
                        }
                        .padding(.bottom)
                    }
                    .onAppear {
                        withAnimation {
                            value.scrollTo("\(currentTime):00:00", anchor: .center)
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: PRIVATE METHODS
    
}


extension TodayView {
    private func getRoundedBorderOverlay(hour: CurrentConditions) -> AnyView {
        if currentTime == hour.datetime.prefix(2) {
            return AnyView(RoundedRectangle(cornerRadius: 7.5)
                .stroke(Color.accentColor, lineWidth: 1))
        } else {
            return AnyView(EmptyView())
        }
    }
}
