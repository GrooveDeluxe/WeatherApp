//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved..
//

import RxSwift
import RxCocoa
import Moya

final class CitiesListVM: Reactor, Coordinatable, Interactable {

    typealias Coordinator = CitiesListCoordinator
    typealias Interactor = CitiesListInteractor

    enum Action {
        case viewLoaded
        case fetchCities
        case addCityTap
        case showCity(Int)
    }

    enum Mutation {
        case setLoading(Bool)
        case setCitiesWeather([CityWeather])
        case deleteCity(Int)
    }

    struct State {
        var isLoading: Bool = false
        var citiesWeather: [CityWeather] = []
    }

    // MARK: - Properties

    let initialState = State()

    // MARK: - Public

    init() {

    }

    func mutate(action: Action) {
        switch action {
        case .viewLoaded:
            interactor.citiesUpdated
                .bind { [weak self] in self?.action.accept(.fetchCities) }
                .disposed(by: disposeBag)
        case .fetchCities:
            interact(interactor.updateCitiesWeather(),
                     complete: CitiesListVM.citiesWeatherUpdated,
                     error: CitiesListVM.citiesWeatherUpdateFailed,
                     inProgress: Mutation.setLoading)
        case .addCityTap:
            coordinator.addCity()
        case .showCity(let cityId):
            coordinator.showCity(cityId: cityId)
            break
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLoading(let loading):
            state.isLoading = loading
        case .setCitiesWeather(let citiesWeather):
            state.citiesWeather = citiesWeather
        case .deleteCity(let cityId):
            interactor.deleteCity(cityId)
            if let index = state.citiesWeather.firstIndex(where: { $0.cityId == cityId }) {
                state.citiesWeather.remove(at: index)
            }
        }
        return state
    }
}

// MARK: - Private -

private extension CitiesListVM {
    func citiesWeatherUpdated(_ citiesWeather: [CityWeather]) {
        // Апи не возвращает локализованные названия городов для запроса по списку айдишников,
        // для этого подменяем на название из базы
        let cities = interactor.cities()
        let prepared = citiesWeather.map { item in
            CityWeather(
                cityId: item.cityId,
                cityName: cities.first(where: { $0.cityId == item.cityId })?.name ?? item.cityName,
                temperature: item.temperature,
                feelsLike:  item.feelsLike,
                description:  item.description,
                visibility:  item.visibility,
                pressure:  item.pressure,
                humidity:  item.humidity,
                windSpeed:  item.windSpeed,
                windDegree:  item.windDegree,
                iconUrl: item.iconUrl
            )
        }
        let sorted = prepared.sorted(by: { $0.cityName < $1.cityName })
        make(.setLoading(false), .setCitiesWeather(sorted))
    }

    func citiesWeatherUpdateFailed(_ error: Error) {
        make(.setLoading(false), .setCitiesWeather([]))
        coordinator.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [.close])
    }

    func citiesWeatherDeleted(_ cityId: Int) {
        make(.deleteCity(cityId))
    }
}
