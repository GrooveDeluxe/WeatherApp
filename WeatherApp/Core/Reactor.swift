//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import RxRelay

extension Reactor where Self: Coordinatable {
    func inject(_ coordinator: Coordinator) {
        set(coordinator: coordinator)
    }
}

extension Reactor where Self: Interactable {
    func inject(_ interactor: Interactor) {
        set(interactor: interactor)
    }
}

protocol Reactor: class, AssociatedStore {
    associatedtype Action
    associatedtype Mutation = Action
    associatedtype State

    var initialState: State { get }

    var state: Observable<State> { get }

    var action: PublishRelay<Action> { get }

    var mutation: PublishRelay<Mutation> { get }

    func mutate(action: Action)

    func reduce(state: State, mutation: Mutation) -> State
}

private enum AssociatedKeys {
    static var actionKey = "action"
    static var mutationKey = "mutation"
    static var stateKey = "state"
    static var subscribedKey = "subscribed"
    static var disposeBagKey = "disposeBag"
}

extension Reactor {
    private var _action: PublishRelay<Action> {
        associatedObject(forKey: &AssociatedKeys.actionKey, default: .init())
    }

    public var action: PublishRelay<Action> {
        _ = _state
        return _action
    }

    private var _mutation: PublishRelay<Mutation> {
        associatedObject(forKey: &AssociatedKeys.mutationKey, default: .init())
    }

    public var mutation: PublishRelay<Mutation> {
        _ = _state
        return _mutation
    }

    private var _state: BehaviorRelay<State> {
        let state = associatedObject(forKey: &AssociatedKeys.stateKey, default: BehaviorRelay<State>(value: initialState))
        if !isSubscribed {
            _action.subscribe(onNext: { self.mutate(action: $0) }).disposed(by: disposeBag)
            _mutation.map { self.reduce(state: state.value, mutation: $0) }.bind(to: state).disposed(by: disposeBag)
            isSubscribed = true
        }
        return state
    }

    public var state: Observable<State> {
        _state.asObservable()
    }

    public var currentState: State {
        _state.value
    }

    private var isSubscribed: Bool {
        get { return associatedObject(forKey: &AssociatedKeys.subscribedKey, default: false) }
        set { setAssociatedObject(newValue, forKey: &AssociatedKeys.subscribedKey) }
    }

    var disposeBag: DisposeBag {
        get { return associatedObject(forKey: &AssociatedKeys.disposeBagKey, default: DisposeBag()) }
    }

    func make(_ mutations: Mutation...) {
        DispatchQueue.main.async { mutations.forEach { [weak self] in self?.mutation.accept($0) } }
    }
}
