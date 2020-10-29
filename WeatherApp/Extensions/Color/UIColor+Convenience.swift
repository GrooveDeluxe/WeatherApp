//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

extension UIColor {
    static let appBlue = NamedColor.blue.color
    static let appBluePressed = NamedColor.bluePressed.color
    static let appGray1 = NamedColor.gray1.color
    static let appGray2 = NamedColor.gray2.color
    static let appGray3 = NamedColor.gray3.color
    static let appGray4 = NamedColor.gray4.color
    static let appForeground = NamedColor.foreground.color
    static let appBackground = NamedColor.background.color
    static let appWhite = NamedColor.white.color
    static let appBlack = NamedColor.black.color
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { [unowned self] rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
