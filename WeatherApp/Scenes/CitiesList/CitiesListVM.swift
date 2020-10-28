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
        case .viewLoaded:
            interactor.citiesUpdated
                .bind { [weak self] in self?.action.accept(.fetchCities) }
                .disposed(by: bag)
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
        case .addCity(let cityId):
            break
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
        let sorted = citiesWeather.sorted(by: { $0.cityName < $1.cityName })
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
