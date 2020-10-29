//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift

protocol Persistable {

    associatedtype ManagedObject: PersistableObject

    init(managedObject: ManagedObject)

    func managedObject() -> ManagedObject
}

extension Persistable {
    func translate() -> Self.ManagedObject {
        return self.managedObject()
    }
}
