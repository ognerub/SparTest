import UIKit

protocol SparPresenterProtocol {
    var navigationBar: UINavigationBar { get set }
    var itemView: UIView { get set }
    var descriptionView: UIView { get set }
    var feedbacksView: UIView { get set }
    func setupSubviews()
}

final class SparPresenter: SparPresenterProtocol {
    
    // MARK: - Navigation bar block properties
    internal var navigationBar: UINavigationBar
    
    private lazy var backButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage.navBarArrow.withRenderingMode(.alwaysOriginal),
            target: self,
            action: #selector(backButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage.navBarHeart.withRenderingMode(.alwaysOriginal),
            target: self,
            action: #selector(likeButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var uploadButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage.navBarUpload.withRenderingMode(.alwaysOriginal),
            target: self,
            action: #selector(uploadButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var catalogButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage.navBarCatalog.withRenderingMode(.alwaysOriginal),
            target: self,
            action: #selector(catalogButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Item view block properties
    internal var itemView: UIView
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImage.itemImage
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var discountImageView: UIImageView = {
        let image = UIImage.discountFive
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var starImageView: UIImageView = {
        let image = UIImage.star
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemRating: Float = 4.1
    
    private let numberOfFeedbacks: Int = 19
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        let rating = NSAttributedString(
            string: "\(itemRating)",
            attributes: [.foregroundColor: UIColor.blackColor]
        )
        let divider = NSAttributedString(
            string: Strings.Common.space.rawValue +
            Strings.Common.divider.rawValue +
            Strings.Common.space.rawValue,
            attributes: [.foregroundColor: UIColor.greyColor]
        )
        let pluralized = String.localizedStringWithFormat(
            Strings.Localized.numberOfFeedbacks.rawValue.localized(),
            numberOfFeedbacks
        )
        let feedbacks = NSAttributedString(
            string: pluralized,
            attributes: [.foregroundColor: UIColor.greyColor]
        )
        let mutableString = NSMutableAttributedString()
        mutableString.append(rating)
        mutableString.append(divider)
        mutableString.append(feedbacks)
        label.attributedText = mutableString
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Description block properties
    internal var descriptionView: UIView
    
    private lazy var itemName: UILabel = {
        let label = UILabel()
        let type = Strings.Localized.itemType.rawValue.localized()
        let name = Strings.Localized.itemName.rawValue.localized()
        let description = Strings.Localized.itemDescription.rawValue.localized()
        let string = type +
        Strings.Common.space.rawValue +
        Strings.Common.quotes.rawValue +
        name +
        Strings.Common.quotes.rawValue +
        Strings.Common.enter.rawValue +
        description
        label.text = string
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryImageView: UIImageView = {
        let image = UIImage.country
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = (
            Strings.Localized.itemCountry.rawValue +
            Strings.CountriesISO.spain.rawValue
        ).localized()
        label.textColor = UIColor.greyColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = (
            Strings.Localized.description.rawValue
        ).localized()
        label.textColor = UIColor.blackColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoTextView: UITextView = {
        let text = UITextView()
        text.text = (
            Strings.Localized.info.rawValue
        ).localized()
        text.textColor = UIColor.blackColor
        text.isScrollEnabled = false
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var featuresLabel: UILabel = {
        let label = UILabel()
        label.text = (
            Strings.Localized.features.rawValue
        ).localized()
        label.textColor = UIColor.blackColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var featuresTable: UITableView = {
        let table = FeaturesTableView()
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var allFeaturesLabel: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(allFeaturesButtonTapped)
        )
        button.setTitle(
            Strings.Localized.allFeatures.rawValue.localized(),
            for: .normal
        )
        button.setTitleColor(UIColor.greenColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Feedback block properties
    private lazy var feedbacksCollectionView: UICollectionView = {
        let collection = FeedbacksCollectionView()
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let allFeedbacksCount: Int = 152
    
    private lazy var allFeedbacksLabel: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(allFeedbacksButtonTapped)
        )
        button.setTitle(
            Strings.Localized.allFeedbacks.rawValue.localized() +
            Strings.Common.space.rawValue +
            String(allFeedbacksCount),
            for: .normal
        )
        button.setTitleColor(UIColor.greenColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Feedbacks block properties
    internal var feedbacksView: UIView
    
    private lazy var feedbacksLabel: UILabel = {
        let label = UILabel()
        label.text = (
            Strings.Localized.feedbacks.rawValue
        ).localized()
        label.textColor = UIColor.blackColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    init(
        navigationBar: UINavigationBar,
        itemView: UIView,
        descriptionView: UIView,
        feedbacksView: UIView
    ) {
        self.navigationBar = navigationBar
        self.itemView = itemView
        self.descriptionView = descriptionView
        self.feedbacksView = feedbacksView
    }
    
    @objc
    private func backButtonTapped() {
        print("backButtonTapped")
    }
    
    @objc
    private func likeButtonTapped() {
        print("likeButtonTapped")
    }
    
    @objc
    private func uploadButtonTapped() {
        print("uploadButtonTapped")
    }
    
    @objc
    private func catalogButtonTapped() {
        print("catalogButtonTapped")
    }
    
    @objc
    private func allFeaturesButtonTapped() {
        print("allFeaturesButtonTapped")
    }
    
    @objc
    private func allFeedbacksButtonTapped() {
        print("allFeedbacksButtonTapped")
    }
    
    func setupSubviews() {
        configureConstraints()
    }
}

// MARK: - Configure constraints

private extension SparPresenter {
    
    func configureConstraints() {
        configureNavigarionBar()
        configureItemView()
        configureDescriptionView()
        configureFeedbacksView()
    }
    
    func configureNavigarionBar() {
        navigationBar.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            backButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 42),
            backButton.widthAnchor.constraint(equalToConstant: 42)
            
        ])
        navigationBar.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            likeButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -10),
            likeButton.heightAnchor.constraint(equalToConstant: 42),
            likeButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        navigationBar.addSubview(uploadButton)
        NSLayoutConstraint.activate([
            uploadButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            uploadButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 0),
            uploadButton.heightAnchor.constraint(equalToConstant: 42),
            uploadButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        navigationBar.addSubview(catalogButton)
        NSLayoutConstraint.activate([
            catalogButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            catalogButton.trailingAnchor.constraint(equalTo: uploadButton.leadingAnchor, constant: 0),
            catalogButton.heightAnchor.constraint(equalToConstant: 42),
            catalogButton.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func configureItemView() {
        itemView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            itemImageView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 218),
            itemImageView.widthAnchor.constraint(equalToConstant: 218)
        ])
        itemView.addSubview(discountImageView)
        NSLayoutConstraint.activate([
            discountImageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -10),
            discountImageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -10),
            discountImageView.heightAnchor.constraint(equalToConstant: 32),
            discountImageView.widthAnchor.constraint(equalToConstant: 49)
        ])
        itemView.addSubview(starImageView)
        NSLayoutConstraint.activate([
            starImageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -10),
            starImageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10),
            starImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        itemView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: discountImageView.leadingAnchor)
        ])
    }
    
    func configureDescriptionView() {
        descriptionView.addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 10),
            itemName.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            itemName.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            itemName.heightAnchor.constraint(equalToConstant: 100)
        ])
        descriptionView.addSubview(countryImageView)
        NSLayoutConstraint.activate([
            countryImageView.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            countryImageView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            countryImageView.heightAnchor.constraint(equalToConstant: 24),
            countryImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        descriptionView.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.centerYAnchor.constraint(equalTo: countryImageView.centerYAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant: 5)
        ])
        descriptionView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: countryImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10)
        ])
        descriptionView.addSubview(infoTextView)
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            infoTextView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            infoTextView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10)
        ])
        descriptionView.addSubview(featuresLabel)
        NSLayoutConstraint.activate([
            featuresLabel.topAnchor.constraint(equalTo: infoTextView.bottomAnchor, constant: 10),
            featuresLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10)
        ])
        descriptionView.addSubview(featuresTable)
        NSLayoutConstraint.activate([
            featuresTable.topAnchor.constraint(equalTo: featuresLabel.bottomAnchor, constant: 10),
            featuresTable.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            featuresTable.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            featuresTable.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -40)
        ])
        descriptionView.addSubview(allFeaturesLabel)
        NSLayoutConstraint.activate([
            allFeaturesLabel.topAnchor.constraint(equalTo: featuresTable.bottomAnchor),
            allFeaturesLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10)
        ])
    }
    
    func configureFeedbacksView() {
        feedbacksView.addSubview(feedbacksLabel)
        NSLayoutConstraint.activate([
            feedbacksLabel.topAnchor.constraint(equalTo: feedbacksView.topAnchor, constant: 10),
            feedbacksLabel.leadingAnchor.constraint(equalTo: feedbacksView.leadingAnchor, constant: 10)
        ])
        feedbacksView.addSubview(allFeedbacksLabel)
        NSLayoutConstraint.activate([
            allFeedbacksLabel.topAnchor.constraint(equalTo: feedbacksView.topAnchor, constant: 10),
            allFeedbacksLabel.trailingAnchor.constraint(equalTo: feedbacksView.trailingAnchor, constant: -10)
        ])
        feedbacksView.addSubview(feedbacksCollectionView)
        NSLayoutConstraint.activate([
            feedbacksCollectionView.topAnchor.constraint(equalTo: feedbacksLabel.bottomAnchor, constant: 10),
            feedbacksCollectionView.leadingAnchor.constraint(equalTo: feedbacksView.leadingAnchor),
            feedbacksCollectionView.trailingAnchor.constraint(equalTo: feedbacksView.trailingAnchor),
            feedbacksCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
