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
        case fetchCities
        case addCityTap
        case deleteCity(Int)
        case showCity(Int)
    }

    enum Mutation {
        case setLoading(Bool)
        case setCitiesWeather([CityWeather])
        case addCity(Int)
        case deleteCity(Int)
    }

    struct State {
        var isLoading: Bool = false
        var citiesWeather: [CityWeather] = []
    }

    // MARK: - Properties

    private let bag = DisposeBag()

    let initialState = State()

    // MARK: - Public

    init() {
        
    }

    func mutate(action: Action) {
        switch action {
        case .fetchCities:
            interact(interactor.updateCitiesWeather(),
                     complete: CitiesListVM.citiesWeatherUpdated,
                     error: CitiesListVM.citiesWeatherUpdateFailed,
                     inProgress: Mutation.setLoading)
        case .deleteCity(let cityId):
            interact(interactor.deleteCity(cityId),
                     complete: CitiesListVM.citiesWeatherDeleted)
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
        case .addCity(let cityId):
            break
        case .deleteCity(let cityId):
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
        make(.setLoading(false), .setCitiesWeather(citiesWeather))
    }

    func citiesWeatherUpdateFailed(_ error: Error) {
        make(.setLoading(false), .setCitiesWeather([]))
        coordinator.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [.close])
    }

    func citiesWeatherDeleted(_ cityId: Int) {
        make(.deleteCity(cityId))
    }
}
