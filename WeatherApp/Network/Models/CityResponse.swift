//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

func kelvinToCelsius(_ kelvin: Double) -> Double {
    kelvin - 273.15
}

struct CityGroupResponse: Decodable {
    let cnt: Int
    let list: [CityResponse]
}

struct CityResponse: Decodable {
    let coord: Coord?
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int
    let wind: Wind?
    let rain: FalloutSpeed?
    let snow: FalloutSpeed?
    let clouds: Clouds?
    let dt: TimeInterval
    let sys: Sys
    let timezone: TimeInterval?
    let id: Int
    let name: String
    let cod: Int?
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    private let icon: String

    var iconUrl: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}

struct Main: Decodable {
    private let temp: Double
    private let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
    let temp_kf: Double?

    var tempCelsius: Double {
        kelvinToCelsius(temp)
    }

    var feelsLikeCelsius: Double {
        kelvinToCelsius(feels_like)
    }

    var tempMinCelsius: Double {
        kelvinToCelsius(temp_min)
    }

    var tempMaxCelsius: Double {
        kelvinToCelsius(temp_max)
    }

//    var pressureMMHG: Int {
//        Int((Double(pressure) / 1000) * 7.50062)
//    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct FalloutSpeed: Decodable {
    let h1: Double?
    let h3: Double?
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
    let pod: String?
}
