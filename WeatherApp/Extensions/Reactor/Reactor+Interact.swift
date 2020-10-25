//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

private var disposeBagKey = "disposeBag"

extension Reactor where Self: Interactable {

    var disposeBag: DisposeBag {
        if let object = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag {
            return object
        }
        let object = DisposeBag()
        objc_setAssociatedObject(self, &disposeBagKey, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return object
    }

    func interact<T>(_ observable: Single<T>,
                     skipIfTrue: Bool = false,
                     complete: @escaping (Self) -> (T) -> Void,
                     error: ((Self) -> (Error) -> Void)? = nil,
                     inProgress: ((Bool) -> Mutation)? = nil,
                     bag: DisposeBag? = nil) {
        guard skipIfTrue == false else { return }

        var obs = observable

        if let inProgress = inProgress {
            make(inProgress(true))
            obs = observable.do(onSuccess: { [weak self] _ in self?.make(inProgress(false)) },
                                onError: { [weak self] _ in self?.make(inProgress(false)) })
        }

        subscribe(obs, complete: complete, error: error, bag: bag)
    }

    func subscribe<T>(_ observer: Single<T>,
                      complete classFunc: @escaping (Self) -> (T) -> Swift.Void,
                      error errClassFunc: ((Self) -> (Error) -> Void)? = nil,
                      bag: DisposeBag? = nil) {
        observer.subscribe(self, complete: classFunc, error: errClassFunc, bag: bag ?? disposeBag)
    }

    func subscribe<T>(_ observer: Single<T>,
                      complete classFunc: @escaping (Self) -> () -> Swift.Void,
                      error errClassFunc: ((Self) -> (Error) -> Void)? = nil,
                      bag: DisposeBag? = nil) {
        observer.subscribe(self, complete: classFunc, error: errClassFunc, bag: bag ?? disposeBag)
    }
}
