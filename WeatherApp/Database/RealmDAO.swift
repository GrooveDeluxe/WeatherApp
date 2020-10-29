//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift

protocol DAO {

    associatedtype P: Persistable

    var managedObjects: Results<P.ManagedObject> { get }
    var objects: [P] { get }

    func persist(object: P)
    func persist(objects: [P])

    func erase(managedObject: P.ManagedObject)
    func erase(managedObjects: [P.ManagedObject])
}

final class RealmDAO<P: Persistable>: DAO {

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
            realm.delete(managedObject)
        }
    }

    func erase(managedObjects: [P.ManagedObject]) {
        managedObjects.forEach { erase(managedObject: $0) }
    }
}
