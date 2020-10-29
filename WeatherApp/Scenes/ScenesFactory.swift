//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

final class ScenesFactory {

    static let shared = ScenesFactory()

    private init() {}

    func citiesList() -> UIViewController {
        let vc = CitiesListVC()
        vc.viewModel = CitiesListVM()
        vc.viewModel.inject(CitiesListCoordinator(vc: vc))
        vc.viewModel.inject(CitiesListInteractor())
        return vc
    }

    func addCity() -> UIViewController {
        let vc = AddCityVC()
        vc.viewModel = AddCityVM()
        vc.viewModel.inject(AddCityCoordinator(vc: vc))
        vc.viewModel.inject(AddCityInteractor())
        return vc
    }

    func showCity(cityId: Int) -> UIViewController {
        let vc = CityDetailVC(title: "Прогноз")
        vc.viewModel = CityDetailVM(cityId: cityId)
        vc.viewModel.inject(CityDetailCoordinator(vc: vc))
        vc.viewModel.inject(CityDetailInteractor())
        return vc
    }
}
