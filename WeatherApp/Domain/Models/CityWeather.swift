//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

struct CityWeather {
    let cityId: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Int
    let description: String
    let visibility: Int
    let pressure: Int
    let humidity: Int
    let windSpeed: Double?
    let windDegree: Int?

    var visibilityKM: String {
        String(format: "%.1f", Double(visibility) / 1000)
    }
}

extension CityWeather: Equatable {}

extension CityResponse {
    var domainModel: CityWeather {
        CityWeather(
            cityId: id,
            cityName: name,
            temperature: main.tempCelsius,
            feelsLike: Int(main.feelsLikeCelsius),
            description: weather.first?.description ?? "",
            visibility: visibility,
            pressure: main.pressure,
            humidity: main.humidity,
            windSpeed: wind?.speed,
            windDegree: wind?.deg
        )
    }
}

extension Array where Element == CityResponse {
    var domainModels: [CityWeather] {
        map { $0.domainModel }
    }
}
