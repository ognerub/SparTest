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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var feedbacksView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cartView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        configureNavigationBar()
        configureItem()
        configureDescription()
        configureFeedbacks()
        configureCart()
        configurePresenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentHeight =
        itemView.frame.height +
        descriptionView.frame.height +
        feedbacksView.frame.height +
        cartView.frame.height
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
    }
    
    private func configurePresenter() {
        presenter = SparPresenter(
            navigationBar: navigationBar,
            itemView: itemView,
            descriptionView: descriptionView,
            feedbacksView: feedbacksView,
            cartView: cartView
        )
        guard let presenter = presenter else { return }
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
    
    func configureItem() {
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
            descriptionView.heightAnchor.constraint(equalToConstant: 530)
        ])
    }
    
    func configureFeedbacks() {
        scrollView.addSubview(feedbacksView)
        NSLayoutConstraint.activate([
            feedbacksView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            feedbacksView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedbacksView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedbacksView.heightAnchor.constraint(equalToConstant: 265)
        ])
    }
    
    func configureCart() {
        scrollView.addSubview(cartView)
        NSLayoutConstraint.activate([
            cartView.topAnchor.constraint(equalTo: feedbacksView.bottomAnchor, constant: 20),
            cartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartView.heightAnchor.constraint(equalToConstant: 110)
        ])
        cartView.layer.shadowColor = UIColor.blackColor.cgColor
        cartView.layer.shadowOpacity = 0.1
        cartView.layer.shadowRadius = 10
        cartView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

