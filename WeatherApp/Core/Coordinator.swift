//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

class Coordinator {
    weak private(set) var vc: UIViewController?

    var vcOrFatal: UIViewController {
        guard let vc = self.vc else {
            fatalError()
        }
        return vc
    }

    required public init(vc: UIViewController) {
        self.vc = vc
    }

    enum PresentType {
        case modally
        case inStack
    }

    final func present(_ vcToPresent: UIViewController, type: PresentType = .inStack) {
        guard let vc = vc else { return }
        switch type {
        case .modally:
            vc.present(vcToPresent, animated: true, completion: nil)
        case .inStack:
            vc.navigationController?.pushViewController(vcToPresent, animated: true)
        }
    }

    final func endEditing() {
        vc?.view.endEditing(true)
    }
}

extension Coordinator {
    func dismiss(completion: (() -> Void)? = nil) {
        guard let vc = vc else { return }
        endEditing()
        vc.dismiss(animated: true, completion: completion)
    }

    func pop() {
        vc?.navigationController?.popViewController(animated: true)
    }

    func close(completion: (() -> Void)? = nil) {
        guard let vc = vc else { return }

        endEditing()

        if let navController = vc.navigationController, navController.viewControllers.count > 1 {
            navController.pop(animated: true, completion: completion)
        } else {
            vc.dismiss(animated: true, completion: completion)
        }
    }
}
