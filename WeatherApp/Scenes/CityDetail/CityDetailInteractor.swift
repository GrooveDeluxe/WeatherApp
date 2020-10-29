//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import Moya

final class CityDetailInteractor {

    private let cityDao = RealmDAO<City>()

    private let provider = MoyaProvider<WeatherTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    func forecastByCityId(_ cityId: Int) -> Single<[Forecast]> {
        provider.rx.request(.forecastByCityId(cityId))
            .filterError(NetworkErrorModel.self)
            .map(ForecastResponse.self)
            .map { $0.list.domainModels }
    }
}
