//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import Moya
import RealmSwift
import RxRelay

final class CitiesListInteractor {

    private let cityDao = RealmDAO<City>()

    private let provider = MoyaProvider<WeatherTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    private var observeToken: NotificationToken!

    private lazy var _citiesUpdated = PublishRelay<Void>()
    lazy var citiesUpdated: Observable<Void> = {
        observeToken = cityDao.managedObjects.observe { (change) in
            self._citiesUpdated.accept(())
        }
        return _citiesUpdated.debounce(.milliseconds(500), scheduler: MainScheduler.instance).asObservable()
    }()

    func updateCitiesWeather() -> Single<[CityWeather]> {
        let cities = cityDao.objects
        guard cities.count > 0 else { return .just([]) }
        return provider.rx.request(.weatherByCityIds(cities.map({ $0.cityId })))
            .map(CityGroupResponse.self)
            .map { $0.list.domainModels }
    }

    func deleteCity(_ cityId: Int) {
        let objects = cityDao.managedObjects.filter({ $0.cityId == cityId })
        cityDao.erase(managedObjects: Array(objects))
    }

    func cities() -> [City] {
        cityDao.objects
    }
}
