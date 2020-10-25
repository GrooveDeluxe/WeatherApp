//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

extension Coordinator {
    func showAlert(title: String?,
                   message: String?,
                   preferredStyle: UIAlertController.Style = .alert,
                   actions: [UIAlertAction],
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alert.addAction($0) }
        vc?.present(alert, animated: true, completion: completion)
    }
}

extension UIAlertAction {
    static let ok = UIAlertAction(title: "Ок", style: .default, handler: nil)
    static let close = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
}
