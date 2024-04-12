import UIKit
import Kingfisher

protocol ImageServiceProtocol {

    func loadImage(for source: URL, to imageView: UIImageView)
    func cancelLoadingImage(in imageView: UIImageView)
}

class ImageService: ImageServiceProtocol {

    init() {
        ImageCache.default.memoryStorage.config.countLimit = Constants.maxImageCountCache
    }

    func loadImage(for source: URL, to imageView: UIImageView) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: source,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ])
    }

    func cancelLoadingImage(in imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}

extension UIImageView {

    func loadImage(for resource: URL) {
        let imageService = Services.shared.imageService
        imageService.loadImage(for: resource, to: self)
    }

    func cancelLoadingImage() {
        let imageService = Services.shared.imageService
        imageService.cancelLoadingImage(in: self)
    }
}
