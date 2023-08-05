//
//  SunriseSunset.swift
//  AsyncSunrise
//
//  Created by Julianne on 8/4/23.
//

import Foundation
import Combine

struct SunriseSunsetResponse: Codable {
    let results: Results
}

struct Results: Codable {
    let sunrise: String
    let sunset: String
}

func fetchSunriseSunsetData() -> AnyPublisher<SunriseSunsetResponse, Error> {
    let urlString = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400"
    guard let url = URL(string: urlString) else {
        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: SunriseSunsetResponse.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main) // Receive on main thread
        .eraseToAnyPublisher()
}
