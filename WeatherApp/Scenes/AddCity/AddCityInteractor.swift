//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import Moya

final class AddCityInteractor {

    private let cityDao = RealmDAO<City>()

    private let provider = MoyaProvider<WeatherTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    func weatherByCityName(_ cityName: String) -> Single<CityWeather> {
        provider.rx.request(.weatherByCityName(cityName))
            .filterError(NetworkErrorModel.self)
            .map(CityResponse.self)
            .map { $0.domainModel }
    }

    func addCityToDB(_ city: City) {
        let objects = cityDao.managedObjects.filter { $0.cityId == city.cityId }
        cityDao.erase(managedObjects: Array(objects))

        cityDao.persist(object: city)
    }
}
