//
//  Created by Dmitry Sochnev.
//  
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: Self {
        guard let delegate = UIApplication.shared.delegate as? Self else {
            fatalError("UIApplication delegate must be type of \(Self.self)")
        }
        return delegate
    }

    var window: UIWindow? {
        didSet {
            guard let window = window else { return }
            appController = AppController(window: window)
        }
    }

    var appController: AppController? {
        didSet {
            appController?.setup()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 13.0, *) {
            // iOS 13 конфигурируется в SceneDelegate
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
        }
        
        return true
    }
}

