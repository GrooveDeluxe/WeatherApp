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
    let minTemp: String
    let maxTemp: String
    let feelsLike: String
    let pressure: String
    let humidity: String

    let groupingDate: Date

    init(forecasts: [Forecast]) {
        if let firstDate = forecasts.first?.date {
            date = dateFormatter.string(from: firstDate)
        } else {
            date = nil
        }

        temp = String(format: "%.f℃", forecasts.averageTemp)
        minTemp = String(format: "%.f℃", forecasts.averageMinTemp)
        maxTemp = String(format: "%.f℃", forecasts.averageMaxTemp)
        feelsLike = String(format: "%.f℃", forecasts.averageFeelsLike)
        pressure =  "\(forecasts.averagePressure)"
        humidity = "\(forecasts.averageHumidity)"

        groupingDate = forecasts.first?.groupingDate ?? Date()
    }
}

extension Array where Element == Forecast {
    var averageTemp: Double {
        map { $0.temp }.reduce(0.0,+) / Double(count)
    }

    var averageMinTemp: Double {
        map { $0.minTemp }.reduce(0.0,+) / Double(count)
    }

    var averageMaxTemp: Double {
        map { $0.maxTemp }.reduce(0.0,+) / Double(count)
    }

    var averageFeelsLike: Double {
        map { $0.feelsLike }.reduce(0.0,+) / Double(count)
    }

    var averagePressure: Int {
        map { $0.pressure }.reduce(0,+) / count
    }

    var averageHumidity: Int {
        map { $0.humidity }.reduce(0,+) / count
    }
}
