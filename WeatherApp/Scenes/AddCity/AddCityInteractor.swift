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
            .map(CityResponse.self)
            .map { $0.domainModel }
    }

    func addCityToDB(_ city: City) {
        if let object = cityDao.collection().first(where: { $0.cityId == city.cityId }) {
            cityDao.erase(by: object.id)
        }
        cityDao.persist(object: city)
    }
}
