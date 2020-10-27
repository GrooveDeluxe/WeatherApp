//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

final class CitiesListCoordinator: Coordinator {
    func addCity() {
        let vc = ScenesFactory.shared.addCity()
        present(vc)
    }

    func showCity(cityId: Int) {
        let vc = ScenesFactory.shared.showCity(cityId: cityId)
        present(vc)
    }
}
