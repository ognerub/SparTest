import UIKit

protocol SparViewControllerProtocol: AnyObject {
    var presenter: SparPresenter? { get set }
}

final class SparViewController: UIViewController {
    
    var presenter: SparPresenter?
    
    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.layer.backgroundColor = UIColor.clear.cgColor
        bar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        return bar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var itemView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        configureNavigationBar()
        configureMainItem()
        configureDescription()
        configurePresenter()
    }
    
    private func configurePresenter() {
        presenter = SparPresenter(
            navigationBar: navigationBar,
            itemView: itemView,
            descriptionView: descriptionView
        )
        guard let presenter = presenter else { return }
        itemView = presenter.itemView
        descriptionView = presenter.descriptionView
        navigationBar = presenter.navigationBar
        presenter.setupSubviews()
    }
}

// MARK: - Configure constraints

private extension SparViewController {
    
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureMainItem() {
        scrollView.addSubview(itemView)
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemView.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
    
    func configureDescription() {
        scrollView.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: itemView.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}

