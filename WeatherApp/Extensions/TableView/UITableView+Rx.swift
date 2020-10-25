//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

extension Reactive where Base: UITableView {
    func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
        (_: Cell.Type)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable
        where Source.Element == Sequence {
            return items(cellIdentifier: Cell.identifier, cellType: Cell.self)
    }
}
