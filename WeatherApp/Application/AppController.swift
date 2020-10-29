//
//  Created by Dmitry Sochnev.
//  
//

import UIKit

protocol AppControllerProtocol {
    func setup()
}

final class AppController {

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
        if cityDao.objects.count == 0 {
            cityDao.persist(objects: Config.defaultCities)
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
