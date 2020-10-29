//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var ddMMMM: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone   = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "dd MMMM"
        return formatter
    }
}
private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone   = TimeZone.autoupdatingCurrent
    formatter.dateFormat = "dd MMMM"
    return formatter
}

struct ForecastRowViewModel {

    let date: String?
    let temp: String
    let description: String?
    let minTemp: String
    let maxTemp: String
    let feelsLike: String
    let pressure: String
    let humidity: String
    let iconUrl: URL?

    init(forecasts: [Forecast]) {
        if let firstDate = forecasts.first?.date {
            date = dateFormatter.string(from: firstDate)
        } else {
            date = nil
        }

        temp = String(format: "%.f ℃", forecasts.temp)
        description = forecasts.first?.description
        minTemp = String(format: "%.f ℃", forecasts.minTemp)
        maxTemp = String(format: "%.f ℃", forecasts.maxTemp)
        feelsLike = String(format: "%.f ℃", forecasts.feelsLike)
        pressure =  "\(forecasts.pressure)"
        humidity = "\(forecasts.humidity)"
        iconUrl = forecasts.first?.iconUrl
    }
}

extension Array where Element == Forecast {
    var temp: Double {
        map { $0.temp }.first ?? 0.0
    }

    var minTemp: Double {
        map { $0.minTemp }.min() ?? 0.0
    }

    var maxTemp: Double {
        map { $0.maxTemp }.max() ?? 0.0
    }

    var feelsLike: Double {
        map { $0.feelsLike }.first ?? 0.0
    }

    var pressure: Int {
        map { $0.pressure }.first ?? 0
    }

    var humidity: Int {
        map { $0.humidity }.first ?? 0
    }
}
