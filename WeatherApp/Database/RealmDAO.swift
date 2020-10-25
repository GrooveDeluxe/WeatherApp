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

    associatedtype DBModel: Persistable

    func object(entityID: String) -> DBModel.ManagedObject?
    func collection() -> Results<DBModel.ManagedObject>

    func persist(object: DBModel)
    func persistAll(objects: [DBModel])

    func erase(object: DBModel)
    func erase(objects: [DBModel])
    func erase()
}

class RealmDAO<P: Persistable>: DAO {

    typealias DBModel = P

    var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("RealmDAO: Can't obtain Realm instance")
        }
        return realm
    }

    func object(entityID: String) -> P.ManagedObject? {
        return realm.object(ofType: P.ManagedObject.self, forPrimaryKey: entityID)
    }

    func collection() -> Results<P.ManagedObject> {
        return realm.objects(P.ManagedObject.self)
    }

    func persist(object: P) {
        try? realm.write {
            realm.add(object.translate(), update: .all)
        }
    }

    func persist(object: P, success: (() -> Void)? = nil, failure: ((NSError) -> Void)? = nil) {
        do {
            try realm.write {
                realm.add(object.translate(), update: .all)
            }
        } catch let error as NSError {
            guard failure != nil else { return }
            failure!(error)
        }

        guard success != nil else { return }
        success!()
    }

    func persistAll(objects: [P]) {
        try? realm.write {
            realm.add(objects.asList(), update: .all)
        }
    }

    func erase(object: P) {
        guard let existing = realm.object(ofType: P.ManagedObject.self, forPrimaryKey: object.translate().id) else {
            return
        }

        try? realm.write {
            realm.delete(existing, cascading: true)
        }
    }

    func erase(objects: [P]) {
        for object in objects {
            erase(object: object)
        }
    }

    func erase() {
        try? realm.write {
            let objects = realm.objects(P.ManagedObject.self)
            realm.delete(objects, cascading: true)
        }
    }
}

extension RealmDAO {
    func object(first: Bool) -> P.ManagedObject? {
        return first ? collection().first : collection().last
    }

    func object(by entityID: String) -> P? {
        return object(entityID: entityID)?.translate(P.self)
    }

    func allObjects() -> [P] {
        return collection().translated(type: P.self)
    }

    func erase(by entityID: String) {
        guard let existing = realm.object(ofType: P.ManagedObject.self, forPrimaryKey: entityID) else {
            return
        }

        try? realm.write {
            realm.delete(existing, cascading: true)
        }
    }
}
