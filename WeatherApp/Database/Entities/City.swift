//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RealmSwift

struct City {
    var cityId: Int
    var name: String
}

final class CityObject: PersistableObject {
    @objc dynamic var cityId: Int = -1
    @objc dynamic var name: String = ""
}

extension City: Persistable {

    typealias ManagedObject = CityObject

    init(managedObject: CityObject) {
        cityId = managedObject.cityId
        name = managedObject.name
    }

    func managedObject() -> CityObject {
        let managedObject = CityObject()
        managedObject.cityId = cityId
        managedObject.name = name
        return managedObject
    }
}
