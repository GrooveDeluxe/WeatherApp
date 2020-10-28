//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

struct CityWeather {
    let cityId: Int
    let cityName: String
    let temperature: Double
    let pressure: Int
}

extension CityWeather: Equatable {}

extension CityResponse {
    var domainModel: CityWeather {
        CityWeather(
            cityId: id,
            cityName: name,
            temperature: main.tempCelsius,
            pressure: main.pressure
        )
    }
}

extension Array where Element == CityResponse {
    var domainModels: [CityWeather] {
        map { $0.domainModel }
    }
}
