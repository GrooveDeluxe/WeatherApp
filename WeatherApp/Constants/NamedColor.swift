//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

// MARK: - Colors -

enum NamedColor: String {
    case blue
    case bluePressed
    case gray1
    case gray2
    case gray3
    case gray4
    case foreground
    case background
    case white
    case black

    var color: UIColor {
        switch self {
        case .blue:
            return .color(
                light: .lightBlue,
                dark: .darkBlue
            )
        case .bluePressed:
            return .color(
                light: .lightBluePressed,
                dark: .darkBluePressed
            )
        case .gray1:
            return .color(
                light: .lightGray1,
                dark: .darkGray1
            )
        case .gray2:
            return .color(
                light: .lightGray2,
                dark: .darkGray2
            )
        case .gray3:
            return .color(
                light: .lightGray3,
                dark: .darkGray3
            )
        case .gray4:
            return .color(
                light: .lightGray4,
                dark: .darkGray4
            )
        case .foreground:
            return .color(
                light: .black,
                dark: .white
            )
        case .background:
            return .color(
                light: .white,
                dark: .black
            )
        case .white:
            return .white
        case .black:
            return .black
        }
    }
}

// MARK: - Color utils -

extension UIColor {
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { traitCollection -> UIColor in
                traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
}
