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
        let stackView = UIStackView(.vertical, spacing: 8, views: rows)
        return stackView
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
                .map { $0.forecasts }
                .distinctUntilChanged()
                .map { forecasts in Dictionary(grouping: forecasts, by: { $0.groupingDate }).mapToRowModels() }
                .map { models in
                    models
                        .map { forecast in ForecastRowView(model: forecast) }
                }
                .bind { [weak self] in
                    self?.setForecastRows($0)
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

    func setForecastRows(_ rows: [ForecastRowView]) {
        stackView.removeAllArrangedSubviews()
        stackView.add(arrangedSubviews: rows)
    }
}

// MARK: - Utils -

private extension CityDetailVC {
    func mapForecastsToViewModels() {

    }
}

extension Dictionary where Key == Date?, Value == [Forecast] {
    func mapToRowModels() -> [ForecastRowViewModel] {
        keys.map { ForecastRowViewModel(forecasts: self[$0] ?? []) }.sorted(by: { $0.groupingDate < $1.groupingDate })
    }
}
