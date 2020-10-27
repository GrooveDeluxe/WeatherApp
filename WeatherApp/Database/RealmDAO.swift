//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift

public struct DAOChangeset {
    public let deleted: [Int]
    public let inserted: [Int]
    public let updated: [Int]
}

protocol DAO {

    associatedtype P: Persistable

    var managedObjects: Results<P.ManagedObject> { get }
    var objects: [P] { get }

    func persist(object: P)
    func persist(objects: [P])

    func erase(managedObject: P.ManagedObject)
    func erase(managedObjects: [P.ManagedObject])
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}

class RealmDAO<P: Persistable>: DAO {

    typealias DBModel = P

    var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("RealmDAO: Can't obtain Realm instance")
        }
        return realm
    }

    var managedObjects: Results<P.ManagedObject> {
        realm.objects(P.ManagedObject.self)
    }

    var objects: [P] {
        managedObjects.translated(type: P.self)
    }

    func persist(object: P) {
        try? realm.write {
            realm.add(object.translate(), update: .all)
        }
    }

    func persist(objects: [P]) {
        try? realm.write {
            realm.add(objects.asList(), update: .all)
        }
    }

    func erase(managedObject: P.ManagedObject) {
        try? realm.write {
            realm.delete(managedObject, cascading: true)
        }
    }

    func erase(managedObjects: [P.ManagedObject]) {
        managedObjects.forEach { erase(managedObject: $0) }
    }
}
