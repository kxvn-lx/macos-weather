//
//  API.swift
//  Weather
//
//  Created by Kevin Laminto on 28/3/2023.
//

import Foundation
import Combine


struct API_URL {
    static let shared = API_URL()
    private let base = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"
    private let params = "unitGroup=metric&elements=datetime%2Cname%2Ctempmax%2Ctempmin%2Ctemp%2Cfeelslikemax%2Cfeelslikemin%2Cfeelslike%2Cdew%2Chumidity%2Cprecip%2Cprecipprob%2Cprecipcover%2Cpreciptype%2Cwindgust%2Cwindspeed%2Cwinddir%2Cvisibility%2Cuvindex%2Csunrise%2Csunset%2Cmoonphase%2Cconditions%2Cdescription"
    private let key = "LCJ42EB2MGKS282JS752LY69V"
    
    
    private init() { }
    
    
    func getURL(from location: String) -> String {
        return "\(base)\(location)?\(params)&key=\(key)&contentType=json"
    }
}

class API {
    private var cancellables = Set<AnyCancellable>()
    
    init() { }
    
    
    // MARK: METHODS
    func fetchWeatherData(from location: String = "melbourne") -> AnyPublisher<Result<WeatherResponse, Error>, Never> {
        guard let url = URL(string: API_URL.shared.getURL(from: location)) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return Just(Result.failure(error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Result<WeatherResponse, Error> in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NSError(domain: "Server Error", code: 0, userInfo: nil)
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                return Result.success(weatherData)
            }
            .catch { error -> Just<Result<WeatherResponse, Error>> in
                Just(Result.failure(error))
            }
            .eraseToAnyPublisher()
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
