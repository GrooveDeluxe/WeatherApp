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

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
}

