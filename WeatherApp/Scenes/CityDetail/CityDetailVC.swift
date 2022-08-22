//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import RxSwift

final class CityDetailVC: BaseVC, ReactorHolder {

    typealias ViewModel = CityDetailVM

    // MARK: - Properties

    var viewModel: ViewModel!

    // MARK: -

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        UIStackView(.vertical, spacing: 8, views: rows)
    }()

    private lazy var rows: [ForecastRowView] = []

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()

        fire(action: .fetchForecast)
    }
}

// MARK: - Bindings -

private extension CityDetailVC {
    func bind() {
        disposeBag.insert([
            viewModel.state
                .map { $0.forecastModels }
                .bind { [weak self] in
                    self?.setForecastRowModels($0)
                }
        ])
    }
}

// MARK: - Setup UI -

private extension CityDetailVC {
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view.snp.width)
        }
    }

    func setForecastRowModels(_ models: [ForecastRowViewModel]) {
        let rows = models.map { ForecastRowView(model: $0) }
        stackView.removeAllArrangedSubviews()
        stackView.add(arrangedSubviews: rows)
    }
}
