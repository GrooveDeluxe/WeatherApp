//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import Moya

enum NetworkError<ErrorModel: Decodable>: Error {
    case logicError(ErrorModel)
}

extension NetworkError: LocalizedError where ErrorModel == NetworkErrorModel {
    var errorDescription: String? {
        switch self {
        case .logicError(let error):
            if error.message == "city not found" {
                return "Город не найден"
            }
            return "Произошла неизвестная ошибка"
        }
    }
}

struct NetworkErrorModel: Decodable {
    let cod: String
    let message: String
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func filterError<ErrorModel: Decodable>(_ errorType: ErrorModel.Type) -> Single<Element> {
        return flatMap { .just(try $0.filterError(errorType)) }
    }
}

public extension Response {
    func filterError<ErrorModel: Decodable>(_ errorType: ErrorModel.Type) throws -> Response {
        if let error = try? map(errorType) {
            throw NetworkError.logicError(error)
        }
        return self
    }
}
