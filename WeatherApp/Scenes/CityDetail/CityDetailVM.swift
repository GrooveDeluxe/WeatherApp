//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

final class CityDetailVM: Reactor/*, Coordinatable, Interactable*/ {

//    typealias Coordinator = AddCityCoordinator
//    typealias Interactor = AddCityInteractor

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
        var cityId: Int
    }

    // MARK: - Properties

    private let bag = DisposeBag()

    let initialState: State

    // MARK: - Public

    init(cityId: Int) {
        initialState = State(cityId: cityId)
    }

    func mutate(action: Action) {

    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        return state
    }
}
