//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

protocol ReactorHolder where Self: UIViewController {
    associatedtype ViewModel: Reactor
    var viewModel: ViewModel! { get set }
}

extension ReactorHolder {
    func fire(action: ViewModel.Action) {
        viewModel?.action.accept(action)
    }
}
