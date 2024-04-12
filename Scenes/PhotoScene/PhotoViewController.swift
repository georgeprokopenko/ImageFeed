import UIKit
import EasyCollectionView

protocol PhotoViewControllerProtocol: BaseViewControllerProtocol {

    func setModel(_ model: PhotoViewController.Model)
}

final class PhotoViewController: UIViewController {

    var viewModel: PhotoViewModelProtocol!

    private lazy var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        view.backgroundColor = Palette.background.color

        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        imageView.pin.all()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.cancelLoadingImage()
    }

    // MARK: - Model

    struct Model {
        let imageResource: URL
    }

    func setModel(_ model: Model) {
        imageView.loadImage(for: model.imageResource)
    }
}

// MARK: - PhotoViewControllerProtocol

extension PhotoViewController: PhotoViewControllerProtocol {
}
