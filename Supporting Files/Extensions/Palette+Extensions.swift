import UIKit
import SwiftUI

extension Palette {

    struct Color: ExpressibleByDictionaryLiteral, Equatable {

        // MARK: Init

        enum InterfaceVariation {
            case light
            case dark
        }

        init(dictionaryLiteral elements: (InterfaceVariation, PaletteColor)...) {
            variations = elements.mapToDict { ($0.0, $0.1.paletteColor) }
        }

        init(variations: [InterfaceVariation: UIColor]) {
            self.variations = variations
        }

        init(singleColor: UIColor) {
            variations = [.light: singleColor, .dark: singleColor]
        }

        private let variations: [InterfaceVariation: UIColor]

        // MARK: Getter

        enum InterfaceStyle {
            case light
            case dark
            case auto

            static func with(_ traitCollection: UITraitCollection) -> InterfaceStyle {
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return .light
                case .dark:
                    return .dark
                case .unspecified:
                    return .light
                @unknown default:
                    return .light
                }
            }
        }

        private func getFallbackColor() -> UIColor {
            variations.values.first ?? .clear
        }

        func color(for interfaceStyle: InterfaceStyle) -> UIColor {
            let fallbackColor = getFallbackColor()

            switch interfaceStyle {
            case .light:
                return variations[.light] ?? fallbackColor

            case .dark:
                return variations[.dark] ?? fallbackColor

            case .auto:
                let light = color(for: .light)
                let dark = color(for: .dark)
                return UIColor { (traitCollection) -> UIColor in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return light
                    case .dark:
                        return dark
                    case .unspecified:
                        return light
                    @unknown default:
                        return light
                    }
                }
            }
        }

        var color: UIColor {
            color(for: .auto)
        }

        var swiftUIColor: SwiftUI.Color {
            SwiftUI.Color(color)
        }

        var inverted: Color {
            .init(variations: [.light: variations[.dark] ?? getFallbackColor(),
                               .dark: variations[.light] ?? getFallbackColor()])
        }

        func withAlphaComponent(_ alpha: CGFloat) -> Color {
            .init(variations: variations._map { ($0, $1.withAlphaComponent(alpha)) })
        }
    }
}

// MARK: Color literals

protocol PaletteColor {
    var paletteColor: UIColor { get }
}

extension Int: PaletteColor {

    var paletteColor: UIColor {
        UIColor(hex: UInt(self))
    }
}

extension UIColor: PaletteColor {

    var paletteColor: UIColor {
        self
    }
}
