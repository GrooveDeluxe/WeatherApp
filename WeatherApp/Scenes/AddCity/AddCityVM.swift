//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

final class AddCityVM: Reactor, Coordinatable, Interactable {

    typealias Coordinator = AddCityCoordinator
    typealias Interactor = AddCityInteractor

    enum Action {
        case addCityName(String)
    }

    enum Mutation {

    }

    struct State {

    }

    // MARK: - Properties

    let initialState = State()

    // MARK: - Public

    init() {

    }

    func mutate(action: Action) {
        switch action {
        case .addCityName(let cityName):
            interact(interactor.weatherByCityName(cityName),
                     complete: AddCityVM.cityWeatherUpdated,
                     error: AddCityVM.cityWeatherUpdateFailed)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}

// MARK: - Private -

private extension AddCityVM {
    func cityWeatherUpdated(_ citiesWeather: CityWeather) {
        let city = City(cityId: citiesWeather.cityId, name: citiesWeather.cityName)
        interactor.addCityToDB(city)
        coordinator.close()
    }

    func cityWeatherUpdateFailed(_ error: Error) {
        coordinator.showAlert(title: L.common.error, message: error.localizedDescription, actions: [.close])
    }
}
