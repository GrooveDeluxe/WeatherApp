//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

extension PrimitiveSequenceType where Self.Trait == RxSwift.SingleTrait {

    func subscribe<T: AnyObject>(_ instance: T,
                                 complete classFunc: @escaping (T)->(Element)->Void,
                                 error errClassFunc: ((T)->(Error)->Void)? = nil,
                                 bag: DisposeBag) {
        self.subscribe(
            onSuccess: { [weak instance] args in
                guard let instance = instance else { return }
                let instanceFunction = classFunc(instance)
                instanceFunction(args)
            }, onError:  { [weak instance] error in
                guard let instance = instance, let errClassFunc = errClassFunc else { return }
                let instanceFunction = errClassFunc(instance)
                instanceFunction(error)
            }
        ).disposed(by: bag)
    }

    func subscribe<T: AnyObject>(_ instance: T,
                                 complete classFunc: @escaping (T)->()->Void,
                                 error errClassFunc: ((T)->(Error)->Void)? = nil,
                                 bag: DisposeBag) {
        self.subscribe(
            onSuccess: { [weak instance] _ in
                guard let instance = instance else { return }
                let instanceFunction = classFunc(instance)
                instanceFunction()
            }, onError:  { [weak instance] error in
                guard let instance = instance, let errClassFunc = errClassFunc else { return }
                let instanceFunction = errClassFunc(instance)
                instanceFunction(error)
            }
        ).disposed(by: bag)
    }
}
