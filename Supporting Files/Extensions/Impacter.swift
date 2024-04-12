import UIKit

final class Impacter {

    static private var impacter: AnyObject? = {
        if NSClassFromString("UIFeedbackGenerator") != nil {
            let generator = UIImpactFeedbackGenerator.init(style: .light)
            generator.prepare()
            return generator
        }
        return nil
    }()

    static private var notificationImpacter: AnyObject? = {
        if NSClassFromString("UINotificationFeedbackGenerator") != nil {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            return generator
        }
        return nil
    }()

    static func impact() {
        if let impacter = impacter as? UIImpactFeedbackGenerator {
            impacter.impactOccurred()
        }
    }

    static func impact(intensity: CGFloat) {
        if let impacter = impacter as? UIImpactFeedbackGenerator {
            impacter.impactOccurred(intensity: intensity)
        }
    }

    static func notificationImpact() {
        if let notificationImpacter = notificationImpacter as? UINotificationFeedbackGenerator {
            notificationImpacter.notificationOccurred(.success)
        }
    }

    static func notificationErrorImpact() {
        if let notificationImpacter = notificationImpacter as? UINotificationFeedbackGenerator {
            notificationImpacter.notificationOccurred(.error)
        }
    }

    static func qrCodeScanSuccess() {
        if let notificationImpacter = notificationImpacter as? UINotificationFeedbackGenerator {
            notificationImpacter.notificationOccurred(.success)
        }
    }

    static func qrCodeScanFailed() {
        if let notificationImpacter = notificationImpacter as? UINotificationFeedbackGenerator {
            notificationImpacter.notificationOccurred(.error)
        }
    }
}
