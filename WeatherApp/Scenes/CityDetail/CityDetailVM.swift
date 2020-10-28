//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

final class CityDetailVM: Reactor, Coordinatable, Interactable {

    typealias Coordinator = CityDetailCoordinator
    typealias Interactor = CityDetailInteractor

    enum Action {
        case fetchForecast
    }

    enum Mutation {
        case setLoading(Bool)
        case setForecasts([Forecast])
    }

    struct State {
        var cityId: Int
        var isLoading: Bool = false
        var forecasts: [Forecast] = []
    }

    // MARK: - Properties

    private let bag = DisposeBag()

    let initialState: State

    // MARK: - Public

    init(cityId: Int) {
        initialState = State(cityId: cityId)
    }

    func mutate(action: Action) {
        switch action {
        case .fetchForecast:
            interact(interactor.forecastByCityId(currentState.cityId),
                     complete: CityDetailVM.forecastUpdated,
                     error: CityDetailVM.forecastUpdateFailed,
                     inProgress: Mutation.setLoading)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        case .setForecasts(let forecasts):
            state.forecasts = forecasts
        }
        return state
    }
}

// MARK: - Private -

private extension CityDetailVM {
    func forecastUpdated(_ forecasts: [Forecast]) {
        make(.setLoading(false), .setForecasts(forecasts))
    }

    func forecastUpdateFailed(_ error: Error) {
        make(.setLoading(false), .setForecasts([]))
        coordinator.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [.close])
    }
}
