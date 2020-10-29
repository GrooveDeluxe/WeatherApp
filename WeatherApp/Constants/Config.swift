//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

enum Config {
    static let appId = "d12373e804bf1ae0224ae48b20ded7c2"

    static var defaultCities: [City] {
        [
            City(cityId: 524901, name: "Москва"),
            City(cityId: 625144, name: "Минск")
        ]
    }

    static let apiBaseUrl = URL(string: "https://api.openweathermap.org/data/2.5/")!
}
