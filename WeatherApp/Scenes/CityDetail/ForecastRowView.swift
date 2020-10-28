//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

final class ForecastRowView: UIView {

    private let dateLabel = UILabel(style: .title3, text: "")
    private let tempLabel = UILabel(style: .title3, text: "")

    private let minTempLabel = UILabel(style: .bodyGray, text: "")
    private let maxTempLabel = UILabel(style: .bodyGray, text: "")

    private let pressureLabel = UILabel(style: .bodyGray, text: "")

    private let humidityLabel = UILabel(style: .bodyGray, text: "")

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(.vertical, spacing: 8, views: [dateStackView, tempStackView, pressureHumidityStackView])
        return stackView
    }()

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(.horizontal, spacing: 8, views: [dateLabel, tempLabel])
        return stackView
    }()

    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(.vertical, spacing: 8, views: [minTempLabel, maxTempLabel])
        return stackView
    }()

    private lazy var pressureHumidityStackView: UIStackView = {
        let stackView = UIStackView(.vertical, spacing: 8, views: [pressureLabel, humidityLabel])
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

        tempLabel.text = model.temp

        minTempLabel.text = "Мин: \(model.minTemp)"
        maxTempLabel.text = "Макс: \(model.maxTemp)"

        pressureLabel.text = "Давление: \(model.pressure) кПа"
        humidityLabel.text = "Влажность: \(model.humidity)%"
    }
}

private extension ForecastRowView {
    func setup() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
