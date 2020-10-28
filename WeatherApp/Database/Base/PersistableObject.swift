//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift
import RxSwift

class PersistableObject: Object {

    @objc dynamic var id: String = NSUUID().uuidString

    override static func primaryKey() -> String? {
        return "id"
    }

    func translate<P: Persistable>(_ type: P.Type) -> P? {
        guard let object = self as? P.ManagedObject else {
            return nil
        }
        return P(managedObject: object)
    }
}

// MARK: - DB Translation

extension Array where Element: Persistable {
    func asList() -> List<Element.ManagedObject> {
        return reduce(List<Element.ManagedObject>()) { (list, persistable) -> List<Element.ManagedObject> in
            list.append(persistable.managedObject())
            return list
        }
    }
}

extension List {
    func asPersistableArray<P: Persistable>() -> [P] where Element == P.ManagedObject {
        map { P(managedObject: $0) }
    }
}

extension Results {
    func translated<P: Persistable>(type: P.Type) -> [P] {
        return compactMap {
            guard let managedObject = $0 as? P.ManagedObject else { return nil }
            return P(managedObject: managedObject)
        }
    }
}
