//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

public protocol Coordinatable: class, AssociatedStore {
    associatedtype Coordinator
    var coordinator: Coordinator { get }
}

private var coordinatorKey = "coordinator"

extension Coordinatable {
    public var coordinator: Coordinator {
        guard let coord: Coordinator =  self.associatedObject(forKey: &coordinatorKey) else {
            fatalError("Coordinator hasn't injected \(self)")
        }
        return coord
    }

    func set(coordinator: Coordinator) {
        self.setAssociatedObject(coordinator, forKey: &coordinatorKey)
    }
}
