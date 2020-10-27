//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift
import RxSwift

final class RealmDB {

    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("RealmDAO: Can't obtain Realm instance")
        }
        return realm
    }

    func cities() -> Single<[City]> {
        let objects = realm.objects(CityObject.self)
        let translated = objects.translated(type: City.self)
        return .just(translated)
    }

    func addCity(_ city: City) {
        let objects = realm.objects(CityObject.self).filter({ $0.cityId == city.cityId })
        realm.delete(objects)

        try? realm.write {
            realm.add(city.managedObject())
        }
    }

    func deleteCity(cityId: Int) {
        let objects = realm.objects(CityObject.self).filter({ $0.cityId == cityId })
        realm.delete(objects)
    }
}
