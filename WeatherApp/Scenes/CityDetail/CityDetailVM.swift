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
        case setForecastModels([ForecastRowViewModel])
    }

    struct State {
        var cityId: Int
        var isLoading: Bool = false
        var forecastModels: [ForecastRowViewModel] = []
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
        case .setForecastModels(let forecastModels):
            state.forecastModels = forecastModels
        }
        return state
    }
}

// MARK: - Private -

private extension CityDetailVM {
    func forecastUpdated(_ forecasts: [Forecast]) {
        let models = Array(preparedForecastModels(forecasts)[1...3])
        make(.setLoading(false), .setForecastModels(models))
    }

    func forecastUpdateFailed(_ error: Error) {
        make(.setLoading(false), .setForecastModels([]))
        coordinator.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [.close])
    }

    typealias GroupedForecast = (date: Date, items: [Forecast])

    func preparedForecastModels(_ forecasts: [Forecast]) -> [ForecastRowViewModel] {
        let grouped = Dictionary(grouping: forecasts, by: { $0.groupingDate })
        // Сгруппированные по секциям элементы преобразуем в массив и восстанавливаем их изначальный порядок
        return forecasts
            .reduce(into: [GroupedForecast]()) { result, item in
                guard !result.contains(where: { $0.date == item.groupingDate }) else { return }
                result.append((date: item.groupingDate, items: grouped[item.groupingDate]!))
            }
            .map { ForecastRowViewModel(forecasts: $0.items) }
    }
}

