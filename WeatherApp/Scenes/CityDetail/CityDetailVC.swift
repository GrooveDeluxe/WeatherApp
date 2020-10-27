//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

final class CityDetailVC: BaseVC, ReactorHolder {

    typealias ViewModel = CityDetailVM

    // MARK: - Properties

    let bag = DisposeBag()

    var viewModel: ViewModel!

    // MARK: -

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .medium17
        textField.textColor = .appBlack
        return textField
    }()

    private lazy var textFieldContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.appGray1.cgColor
        container.addSubview(textField)
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        return container
    }()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()

        fire(action: .fetchCities)
    }
}

// MARK: - Bindings -

private extension CityDetailVC {
    func bind() {
        disposeBag.insert([

        ])
    }
}

// MARK: - Setup UI -

private extension CityDetailVC {
    func setupUI() {
        view.addSubview(textFieldContainer)
        textFieldContainer.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
    }
}
