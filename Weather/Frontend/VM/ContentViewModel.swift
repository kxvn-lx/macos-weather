//
//  ContentViewModel.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var searchText = ""
    private var location = "Melbourne"
    private var cancellables = Set<AnyCancellable>()
    private let api = API()
    
    
    init() {
        refresh { _ in }
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func onTextfieldSubmit() {
        guard !searchText.isEmpty else { return }
        
        api.fetchWeatherData(from: searchText)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                    self.location = self.searchText
                    self.searchText = ""
                case .failure(let error):
                    print(error)
                }
            }
            .store(in: &cancellables)
    }
    
    func refresh(onFinish: @escaping (_ status: Bool) -> Void) {
        api.fetchWeatherData(from: location)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                    onFinish(true)
                case .failure(let error):
                    print(error)
                    onFinish(false)
                }
            }
            .store(in: &cancellables)
    }
    
}

