//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

class CitiesListItemCell: UITableViewCell {

    private let cityNameLabel = UILabel(style: .title1, text: "", lines: 0)
    private let cityTemperatureLabel = UILabel(style: .title2, text: "")

    private lazy var mainContentView: UIView = {
        return UIStackView(.horizontal, spacing: 8, distribution: .equalSpacing, alignment: .center,
                           views: [cityNameLabel, cityTemperatureLabel])
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setModel(_ model: CityWeather) {
        cityNameLabel.text = model.cityName
        cityTemperatureLabel.text = String(format: "%.f℃", model.temperature)
    }
}

private extension CitiesListItemCell {
    func setup() {
        contentView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
