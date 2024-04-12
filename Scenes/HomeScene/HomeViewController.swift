import UIKit
import EasyCollectionView

protocol HomeViewControllerProtocol: BaseViewControllerProtocol, CollectionViewControllerProtocol {
}

final class HomeViewController: UIViewController, CollectionViewController {

    var dataSource = CommonCollectionViewDataSource()
    var viewModel: HomeViewModelProtocol!

    // MARK: - Layout

    lazy var collectionView: UICollectionView! = {
        let layout = ECFlowLayout()
        layout.flowLayoutDelegate = self
        layout.interceptAnimations = false

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.clipsToBounds = true

        let control = UIRefreshControl()
        control.tintColor = Palette.interfaceBlack.color
        control.addTarget(self, action: #selector(didActivatePullToRefresh), for: .valueChanged)
        collectionView.refreshControl = control

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(collectionView)
        view.backgroundColor = Palette.background.color

        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.pin.all()
    }

    @objc private func didActivatePullToRefresh() {
        viewModel.viewDidRefresh()
    }
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {

    func reloadCollectionView(with rows: [any CommonRowViewModelProtocol], animated: Bool) {
        reloadCollectionView(with: rows, animated: animated, completion: nil)
        collectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - FlowLayoutDelegate

extension HomeViewController: ECFlowLayoutDelegate {

    func heightForItem(at indexPath: IndexPath, with width: CGFloat, in collectionView: UICollectionView) -> CGFloat {
        dataSource.itemForIndexPath(indexPath)?.height?(with: width) ?? 0
    }

    func spacing(
        between indexPath: IndexPath,
        and anotherIndexPath: IndexPath,
        with width: CGFloat,
        in collectionView: UICollectionView
    ) -> CGFloat? {
        5
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dataSource.itemForIndexPath(indexPath)?.didHide?(cell: cell)
    }
}
