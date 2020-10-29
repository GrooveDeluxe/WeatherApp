//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

final class CitiesListItemCell: UITableViewCell {

    private let cityNameLabel = UILabel(style: .title1, text: "", lines: 0)

    private lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints {
            $0.size.lessThanOrEqualTo(CGSize(width: 40, height: 40))
        }
        return icon
    }()

    private let cityTempLabel = UILabel(style: .title2, text: "")

    private let descriptionLabel = UILabel(style: .description, text: "", lines: 0)
    private let visibilityLabel = UILabel(style: .description, text: "")
    private let pressureLabel = UILabel(style: .description, text: "")
    private let humidityLabel = UILabel(style: .description, text: "")
    private let windLabel = UILabel(style: .description, text: "")

    private lazy var mainContentView: UIView = {
        let container = UIView()
        let stackView = UIStackView(.vertical, spacing: 8, views: [
            UIStackView(.horizontal, spacing: 8, distribution: .equalSpacing, alignment: .center, views: [
                cityNameLabel,
                UIStackView(.horizontal, spacing: 8, distribution: .equalSpacing, alignment: .center, views: [
                    weatherIcon,
                    cityTempLabel
                ])
            ]),
            descriptionLabel,
            visibilityLabel,
            pressureLabel,
            humidityLabel,
            windLabel
        ])

        container.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        return container
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

        weatherIcon.load(url: model.iconUrl)
        cityTempLabel.text = String(format: "%.f ℃", model.temperature)

        descriptionLabel.text = "Ощущается как \(model.feelsLike) ℃. \(model.description.capitalizingFirstLetter())"
        visibilityLabel.text = "Видимость \(model.visibilityKM) км"

        pressureLabel.text = "Давление \(model.pressure) кПа"
        humidityLabel.text = "Влажность \(model.humidity)%"

        if let windSpeed = model.windSpeed, let windDegree = model.windDegree {
            let directions = "С,ССВ,СВ,ВСВ,В,ВЮВ,ЮВ,ЮЮВ,Ю,ЮЮЗ,ЮЗ,ЗЮЗ,З,ЗСЗ,СЗ,ССЗ,С".split(separator: ",")
            let speed = String(format: "%.f",windSpeed)
            windLabel.text = "Ветер \(speed) м/с (\(directions[Int(Double(windDegree) / 22.5)]))"
        }

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
