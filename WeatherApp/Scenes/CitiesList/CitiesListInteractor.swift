//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import Moya

final class CitiesListInteractor {

    private let cityDao = RealmDAO<City>()

    private let provider = MoyaProvider<WeatherTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    func updateCitiesWeather() -> Single<[CityWeather]> {
        let cities = cityDao.allObjects()
        guard cities.count > 0 else { return .just([]) }
        return provider.rx.request(.weatherByCityIds(cities.map({ $0.cityId })))
            .map(CityGroupResponse.self)
            .map { $0.list.domainModels }
    }

    func deleteCity(_ cityId: Int) -> Single<Int> {
        guard let object = cityDao.collection().first(where: { $0.cityId == cityId }) else { return .never() }
        cityDao.erase(by: object.id)
        return .just(cityId)
    }
}
