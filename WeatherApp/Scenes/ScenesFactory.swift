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
}
