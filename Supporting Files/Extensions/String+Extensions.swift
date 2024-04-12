import UIKit
import EasyCollectionView

extension String {

    func size(with font: UIFont, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let nsString = self as NSString
        let rect = nsString.boundingRect(with: CGSize(width: width, height: height),
                                         options: [.usesLineFragmentOrigin, .usesFontLeading],
                                         attributes: [NSAttributedString.Key.font: font],
                                         context: nil)

        return CGSize(width: Pixel.ceilToPixel(rect.width), height: Pixel.ceilToPixel(rect.height))
    }

    func height(with font: UIFont, width: CGFloat) -> CGFloat {
        size(with: font, width: width).height
    }

    func width(with font: UIFont, height: CGFloat) -> CGFloat {
        size(with: font, height: height).width
    }
}
