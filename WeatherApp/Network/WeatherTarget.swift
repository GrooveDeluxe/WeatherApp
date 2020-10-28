//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Moya

enum WeatherTarget {
    /// GET
    /// weather?q={city name},{state code},{country code}&appid={API key}
    case weatherByCityName(String)

    /// GET
    /// weather?id={city id}&appid={API key}
    case weatherByCityId(Int)

    /// GET
    /// weather?id={id,..,id}&appid={API key}
    case weatherByCityIds([Int])

    /// GET
    /// forecast?id={city ID}&appid={API key}
    case forecastByCityId(Int)
}

extension WeatherTarget: TargetType {

    private var lang: String {
        return Locale.current.languageCode ?? Locale.current.identifier
    }

    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var path: String {
        switch self {
        case .weatherByCityName:    return "weather"
        case .weatherByCityId:      return "weather"
        case .weatherByCityIds:     return "group"
        case .forecastByCityId:     return "forecast"
        }
    }

    var method: Moya.Method {
        switch self {
        case .weatherByCityName,
             .weatherByCityId,
             .weatherByCityIds,
             .forecastByCityId:
            return .get
        }
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case .weatherByCityName(let name):
            return .requestParameters(
                parameters: [
                    "q": name,
                    "lang": lang,
                    "appid": Config.appId
                ],
                encoding: URLEncoding.default
            )
        case .weatherByCityId(let id):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "lang": lang,
                    "appid": Config.appId
                ],
                encoding: URLEncoding.default
            )
        case .weatherByCityIds(let ids):
            return .requestParameters(
                parameters: [
                    "id": ids.map { "\($0)" }.joined(separator: ","),
                    "lang": lang,
                    "appid": Config.appId
                ],
                encoding: URLEncoding.default
            )
        case .forecastByCityId(let id):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "lang": lang,
                    "appid": Config.appId
                ],
                encoding: URLEncoding.default
            )
        }
    }

    var validationType: ValidationType {
        return .none
    }

    var headers: [String: String]? {
        return nil
    }
}
