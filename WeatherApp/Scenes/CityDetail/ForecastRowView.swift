//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

final class ForecastRowView: UIView {

    private let dateLabel = UILabel(style: .title3, text: "")

    private lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints {
            $0.size.lessThanOrEqualTo(CGSize(width: 40, height: 40))
        }
        return icon
    }()

    private let tempLabel = UILabel(style: .title3, text: "")

    private let descriptionLabel = UILabel(style: .bodyGray, text: "")

    private let minTempLabel = UILabel(style: .bodyGray, text: "")
    private let maxTempLabel = UILabel(style: .bodyGray, text: "")

    private let pressureLabel = UILabel(style: .bodyGray, text: "")

    private let humidityLabel = UILabel(style: .bodyGray, text: "")

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(.vertical, spacing: 8, views: [
            UIStackView(.horizontal, spacing: 8, views: [
                dateLabel,
                UIStackView(.horizontal, spacing: 8, views: [weatherIcon,tempLabel])
            ]),
            descriptionLabel,
            minTempLabel,
            maxTempLabel,
            pressureLabel,
            humidityLabel
        ])
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(model: ForecastRowViewModel) {
        self.init(frame: .zero)

        dateLabel.text = model.date

        weatherIcon.load(url: model.iconUrl)
        tempLabel.text = model.temp

        descriptionLabel.text = model.description?.capitalizingFirstLetter()

        minTempLabel.text = "Мин: \(model.minTemp)"
        maxTempLabel.text = "Макс: \(model.maxTemp)"

        pressureLabel.text = "Давление: \(model.pressure) кПа"
        humidityLabel.text = "Влажность: \(model.humidity)%"
    }
}

private extension ForecastRowView {
    func setup() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
