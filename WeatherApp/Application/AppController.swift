//
//  Created by Dmitry Sochnev.
//  
//

import UIKit

protocol AppControllerProtocol {
    func setup()
}

class AppController {

    weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
}

extension AppController: AppControllerProtocol {
    func setup() {
        initialize()
        setupInitialViewController()
    }
}

// MARK: Private
extension AppController {

    func initialize() {
        let cityDao = RealmDAO<City>()
        if cityDao.collection().count == 0 {
            cityDao.persistAll(objects: [
                City(cityId: 524901, name: "Москва"),
                City(cityId: 625144, name: "Минск")
            ])
        }
    }

    // MARK: - Initial screen
    private func setupInitialViewController() {
        let vc = ScenesFactory.shared.citiesList()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
