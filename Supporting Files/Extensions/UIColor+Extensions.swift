import Foundation
import UIKit

public extension UIColor {

    /// hex: 0xRRGGBB or 0xAARRGGBB // spellr:disable:line
    convenience init(hex: UInt, forceAlpha: Bool = false) {
        let redComp: UInt = (hex >> 16) & 0xFF
        let red = CGFloat(redComp) / 255.0

        let greenComp: UInt = (hex >> 8) & 0xFF
        let green = CGFloat(greenComp) / 255.0

        let blueComp = (hex >> 0) & 0xFF
        let blue = CGFloat(blueComp) / 255.0

        let alpha: CGFloat = (forceAlpha || hex > 0xFFFFFF) ? CGFloat((hex >> 24) & 0xFF) / CGFloat(0xFF) : CGFloat(1)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        guard cString.count == 6 || cString.count == 8 else {
            self.init(hex: 0xFF0000)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(hex: UInt(rgbValue), forceAlpha: cString.count == 8)
    }

    var suiColor: Color {
        Color(self)
    }
}

import SwiftUI

public extension Color {
    static func hex(_ value: UInt, forceAlpha: Bool = false) -> Color {
        Color(UIColor(hex: value, forceAlpha: forceAlpha))
    }
}
