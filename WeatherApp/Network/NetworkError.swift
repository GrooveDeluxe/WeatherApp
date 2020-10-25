//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case undefined
    case underlying(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .undefined:
            return "Undefined network error"
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
