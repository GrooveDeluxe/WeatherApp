//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

protocol IdentifiableCell {
    static var identifier: String { get }
}

extension IdentifiableCell {
    static var identifier: String {
        "\(self)"
    }
}

extension UITableViewCell: IdentifiableCell {}

extension UITableView {
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func dequeueCell<T: UITableViewCell>(_ : T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Can't dequeue cell with identifier - \(T.identifier)")
        }
        return cell
    }

    func dequeueCell<T: UITableViewCell>(_ : T.Type, for row: Int) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Can't dequeue cell with identifier - \(T.identifier)")
        }
        return cell
    }
}
