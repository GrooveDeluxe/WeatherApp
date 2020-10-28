//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift
import RxKeyboard
import SnapKit

final class AddCityVC: BaseVC, ReactorHolder {

    typealias ViewModel = AddCityVM

    // MARK: - Properties

    var viewModel: ViewModel!

    // MARK: -

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .medium17
        textField.textColor = .appBlack
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var textFieldContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.appGray1.cgColor
        container.addSubview(textField)
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        return container
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = .bold20
        button.titleLabel?.textColor = .appWhite
        button.setBackgroundImage(UIColor.appBlue.image(), for: .normal)
        button.setBackgroundImage(UIColor.appBluePressed.image(), for: .selected)
        button.setBackgroundImage(UIColor.appBluePressed.image(), for: .highlighted)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.snp.makeConstraints { $0.height.equalTo(40) }
        return button
    }()

    private var addButtonBottom: Constraint!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        textField.becomeFirstResponder()
    }
}

// MARK: - Bindings -

private extension AddCityVC {
    func bind() {
        disposeBag.insert([

            textField.rx.text
                .map { !($0?.isEmpty ?? false) }
                .bind(to: addButton.rx.isEnabled),

            addButton.rx.tap
                .withLatestFrom(textField.rx.text)
                .map { ViewModel.Action.addCityName($0 ?? "") }
                .bind(to: viewModel.action),

            RxKeyboard.instance.visibleHeight.drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let self = self else { return }

                var actualKeyboardHeight = keyboardVisibleHeight
                if keyboardVisibleHeight > 0 {
                    actualKeyboardHeight = actualKeyboardHeight - self.view.safeAreaInsets.bottom
                }

                self.addButtonBottom.update(inset: 32 + actualKeyboardHeight)
                self.view.layoutIfNeeded()
            })
        ])
    }
}

// MARK: - Setup UI -

private extension AddCityVC {
    func setupUI() {

        view.addSubview(textFieldContainer)
        textFieldContainer.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }

        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            addButtonBottom = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32).constraint
        }
    }
}
