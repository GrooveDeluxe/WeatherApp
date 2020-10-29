//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

let isoDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone   = TimeZone.autoupdatingCurrent
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

struct Forecast {
    let date: Date?
    let temp: Double
    let description: String?
    let minTemp: Double
    let maxTemp: Double
    let feelsLike: Double
    let iconUrl: URL?
    let visibility: Int
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDegree: Int

    var groupingKey: String {
        guard let date = date else { return "" }
        return String(Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)?.timeIntervalSince1970 ?? 0)
    }
}

extension Forecast: Equatable {}

extension ForecastItem {
    var domainModel: Forecast {
        Forecast(
            date: isoDateFormatter.date(from: dt_txt),
            temp: main.tempCelsius,
            description: weather.first?.description,
            minTemp: main.tempMinCelsius,
            maxTemp: main.tempMaxCelsius,
            feelsLike: main.feelsLikeCelsius,
            iconUrl: weather.first?.iconUrl,
            visibility: visibility,
            pressure: main.pressure,
            humidity: main.humidity,
            windSpeed: wind.speed,
            windDegree: wind.deg
        )
    }
}

extension Array where Element == ForecastItem {
    var domainModels: [Forecast] {
        map { $0.domainModel }
    }
}
