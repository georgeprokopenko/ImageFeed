import UIKit

extension UILabel {

    convenience init(font: UIFont? = nil, textColor: UIColor? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment = .natural, adjustsFontSizeToFitWidth: Bool = false, minimumScaleFactor: CGFloat = 0, text: String? = nil) {
        self.init()

        if let font = font {
            self.font = font
        }

        if let textColor = textColor {
            self.textColor = textColor
        }

        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }

        if let text = text {
            self.text = text
        }

        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.minimumScaleFactor = minimumScaleFactor
    }
}
