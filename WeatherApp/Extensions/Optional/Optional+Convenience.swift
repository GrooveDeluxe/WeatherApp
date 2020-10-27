//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

extension Optional where Wrapped: StringProtocol {
    var selfOrEmpty: Wrapped {
        return self ?? ""
    }
}
