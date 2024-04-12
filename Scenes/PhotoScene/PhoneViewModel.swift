import Foundation

protocol PhotoViewModelProtocol: BaseViewModelProtocol {

    func viewDidLoad()
}

final class PhotoViewModel {

    weak var viewController: PhotoViewControllerProtocol?
    private let item: FeedItem

    init(item: FeedItem) {
        self.item = item
    }
}

// MARK: - PhotoViewModelProtocol

extension PhotoViewModel: PhotoViewModelProtocol {

    func viewDidLoad() {
        viewController?.setModel(
            .init(imageResource: item.src.original)
        )
    }
}
