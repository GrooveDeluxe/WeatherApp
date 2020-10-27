//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit
import RxSwift

protocol DisposeBagHolder {
    var disposeBag: DisposeBag { get }
}

class BaseVC: UIViewController, DisposeBagHolder {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        view.layoutMargins = .zero
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
