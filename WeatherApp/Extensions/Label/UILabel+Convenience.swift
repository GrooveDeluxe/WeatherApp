//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

typealias Attributes = [NSAttributedString.Key: Any]

public enum AnyString {
    case string(String)
    case attributed(NSAttributedString)
}

extension UILabel {

    func set(text: AnyString?) {
        guard let text = text else {
            self.attributedText = nil
            self.text = nil
            return
        }

        switch text {
        case .string(let str):
            self.attributedText = nil
            self.text = str
        case .attributed(let str):
            self.text = nil
            self.attributedText = str
        }
    }

    convenience init(font: UIFont? = nil, color: UIColor? = nil, alignment: NSTextAlignment = .left, maxLines: Int = 0) {
        self.init()
        self.textAlignment = alignment
        self.font = font
        self.textColor = color
        self.numberOfLines = maxLines
    }

    convenience init(style: Style, text: String? = nil , lines: Int = 1, alignment: NSTextAlignment = .natural) {
        self.init()
        self.font = style.font
        self.textColor = style.color
        self.text = text
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}

extension UILabel {
    enum Style: String {
        case largeTitle
        case title1
        case title2
        case title3
        case body
        case bodyGray
        case bodyOrange
        case bodyRed
        case bodyBold
        case bodyBoldGray
        case link
        case success
        case failure
        case optionButtonTitle
        case tertiaryButtonTitle
        case primaryButtonTitle
        case textFieldTitle
        case textFieldText
        case textFieldPlaceholder
        case textFieldError
        case description

        var attributes: Attributes {
            Self.attributesInfo[self] ?? [:]
        }

        var font: UIFont {
            attributes[.font] as! UIFont
        }

        var color: UIColor {
            attributes[.foregroundColor] as! UIColor
        }

        private static let attributesInfo: [Self: Attributes] = [
            .title1: [
                .font: UIFont.bold28,
                .foregroundColor: UIColor.appForeground
            ],
            .title2: [
                .font: UIFont.bold22,
                .foregroundColor: UIColor.appForeground
            ],
            .title3: [
                .font: UIFont.bold20,
                .foregroundColor: UIColor.appForeground
            ],
            .body: [
                .font: UIFont.regular17,
                .foregroundColor: UIColor.appForeground
            ],
            .description: [
                .font: UIFont.regular16,
                .foregroundColor: UIColor.appGray3
            ]
        ]
    }
}


