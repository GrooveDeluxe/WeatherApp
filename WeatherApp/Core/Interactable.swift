//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

public protocol Interactable: class, AssociatedStore  {
    associatedtype Interactor
    var interactor: Interactor { get }
}

private enum AssociatedKeys {
    static var interactorKey = "interactor"
}

extension Interactable {

    public var interactor: Interactor {
        guard let interactor: Interactor = self.associatedObject(forKey: &AssociatedKeys.interactorKey) else {
            fatalError("Interactor hasn't injected \(self)")
        }
        return interactor
    }

    func set(interactor: Interactor) {
        self.setAssociatedObject(interactor, forKey: &AssociatedKeys.interactorKey)
    }
}
