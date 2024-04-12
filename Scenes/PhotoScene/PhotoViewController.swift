import UIKit
import EasyCollectionView

protocol PhotoViewControllerProtocol: BaseViewControllerProtocol {

    func setModel(_ model: PhotoViewController.Model)
}

final class PhotoViewController: UIViewController {

    var viewModel: PhotoViewModelProtocol!

    private lazy var imageView = UIImageView()
    private lazy var authorView = AuthorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(imageView, authorView)
        imageView.contentMode = .scaleAspectFill
        view.backgroundColor = Palette.background.color

        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        imageView.pin.all()

        authorView.pin
            .topLeft(16)
            .sizeToFit()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.cancelLoadingImage()
    }

    // MARK: - Model

    struct Model {
        let author: String
        let imageResource: URL
    }

    func setModel(_ model: Model) {
        imageView.loadImage(for: model.imageResource)
        authorView.setModel(.init(text: model.author))
    }
}

// MARK: - PhotoViewControllerProtocol

extension PhotoViewController: PhotoViewControllerProtocol {
}
