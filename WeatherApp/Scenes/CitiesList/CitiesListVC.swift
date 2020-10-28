//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved..
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

struct CitiesList {
    typealias Section = String
    typealias Item = CityWeather
}

extension CityWeather: IdentifiableType {
    public var identity: String {
        "\(cityId)"
    }
}

final class CitiesListVC: BaseVC, ReactorHolder {

    typealias ViewModel = CitiesListVM

    // MARK: - Properties

    var viewModel: ViewModel!

    // MARK: -

    private  typealias Section = AnimatableSectionModel<CitiesList.Section, CitiesList.Item>

    private lazy var dataSource: RxTableViewSectionedAnimatedDataSource<Section> = {
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            configureCell: { [weak self] _, tableView, indexPath, model in
                guard let self = self else { return UITableViewCell() }
                let cell = tableView.dequeueCell(CitiesListItemCell.self, for: indexPath)
                cell.setModel(model)
                return cell
            })

        dataSource.canEditRowAtIndexPath = { _, _ in
            return true
        }

        return dataSource
    }()

    private let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

    private let refreshControl = UIRefreshControl()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()

        tableView.register(CitiesListItemCell.self)

        return tableView
    }()

    private lazy var loadingView: UIView = {
        let container = UIView()
        let activity = UIActivityIndicatorView(style: .white)
        activity.color = .appGray4
        activity.startAnimating()

        let label = UILabel(style: .body, text: "Обновляем", lines: 0, alignment: .center)
        let stack = UIStackView(.vertical, spacing: 16, alignment: .center, views: [activity, label])
        container.addSubview(stack)
        stack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
        }
        return container
    }()

    private lazy var emptyView: UIView = {
        let container = UIView()
        let label = UILabel(style: .body, text: "У Вас не добавлено городов", lines: 0, alignment: .center)
        container.addSubview(label)
        label.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
        }
        return container
    }()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()

        fire(action: .viewLoaded)
        fire(action: .fetchCities)
    }
}

// MARK: - Bindings -

private extension CitiesListVC {
    func bind() {
        disposeBag.insert([
            refreshControl.rx.controlEvent(.valueChanged)
                .filter { [weak self] in self?.refreshControl.isRefreshing ?? false }
                .map { ViewModel.Action.fetchCities }
                .bind(to: viewModel.action),

            viewModel.state
                .map { [Section(model: "", items: $0.citiesWeather)] }
                .observeOn(MainScheduler.instance)
                .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
                .bind(to: tableView.rx.items(dataSource: dataSource)),

            tableView.rx.modelSelected(CityWeather.self)
                .map { $0.cityId }
                .map(ViewModel.Action.showCity)
                .bind(to: viewModel.action),

            tableView.rx.modelDeleted(CityWeather.self)
                .map { $0.cityId }
                .map(ViewModel.Mutation.deleteCity)
                .bind(to: viewModel.mutation),

            tableView.rx.itemSelected
                .bind { [weak self] in self?.tableView.deselectRow(at: $0, animated: true) },

            viewModel.state
                .bind { [weak self] in
                    self?.showStateView(isLoading: $0.isLoading, isEmpty: $0.citiesWeather.isEmpty)
                },

            addButton.rx.tap
                .map { ViewModel.Action.addCityTap }
                .bind(to: viewModel.action)
        ])
    }
}

// MARK: - Setup UI -

private extension CitiesListVC {
    func setupUI() {
        navigationItem.rightBarButtonItem = addButton

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func showStateView(isLoading: Bool, isEmpty: Bool) {
        tableView.backgroundView = isLoading && isEmpty ? loadingView : isEmpty ? emptyView : nil
    }
}
