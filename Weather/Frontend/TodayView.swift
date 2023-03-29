//
//  TodayView.swift
//  Weather
//
//  Created by Kevin Laminto on 29/3/2023.
//

import SwiftUI

struct TodayView: View {
    private let day: Day?
    private var currentTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: Date())
    }
    
    init(weatherResponse: WeatherResponse?) {
        self.day = weatherResponse?.days.first
    }
    
    
    var body: some View {
        if let day = day {
            VStack(alignment: .leading) {
                Text(day.conditions.rawValue)
                Text("\(day.temp, specifier: "%.1f") celcius")
                
                ScrollViewReader { value in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(day.hours, id: \.datetime) { hour in
                                ZStack {
                                    currentTime == hour.datetime.prefix(2) ?
                                    Color.gray.opacity(0.25).cornerRadius(8) :
                                    Color.clear.opacity(1).cornerRadius(8)
                                    
                                    VStack(alignment: .leading) {
                                        Text(hour.datetime.prefix(5))
                                        Text("\(hour.temp, specifier: "%.1f")")
                                    }
                                    .id(hour.datetime)
                                    .padding(.vertical)
                                    .padding(.horizontal, 2.5)
                                }
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
