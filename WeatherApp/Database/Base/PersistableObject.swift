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

extension Array {
    func asPersistableArray<P: Persistable>(_ type: P.Type) -> [P] where Element == P.ManagedObject {
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

extension Sequence where Element == PersistableObject {
//    func sum() -> Int {
//        var result = 0
//        _ = self.map { result += $0 }
//        return result
//    }
    func translated<P: Persistable>(type: P.Type) -> [P] {
        return compactMap {
            guard let managedObject = $0 as? P.ManagedObject else { return nil }
            return P(managedObject: managedObject)
        }
    }
}

// MARK: - DB Translation Observable

extension ObservableType where Element: PersistableObject {

    func translate<P: Persistable>(_ type: P.Type) -> Observable<P> {
        return self.flatMap({ object -> Observable<P> in
            guard let object = object.translate(type) else {
                return Observable.empty()
            }
            return Observable.just(object)
        })
    }
}

extension ObservableType {

    func translate<P: Persistable>(_ type: P.Type) -> Observable<([P], DAOChangeset?)> where Element == ([P.ManagedObject], DAOChangeset?) {
        return self.flatMap({ (tuple) -> Observable<([P], DAOChangeset?)> in
            return Observable.just((tuple.0.asPersistableArray(type), tuple.1))
        })
    }
}
