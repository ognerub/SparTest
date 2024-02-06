import UIKit

protocol SparPresenterProtocol {
    func setupSubviews()
}

final class SparPresenter: SparPresenterProtocol {
    
    // MARK: - Navigation bar block properties
    private let navigationBar: UINavigationBar
    
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
    private let itemView: UIView
    
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
    private let descriptionView: UIView
    
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
    private let feedbacksView: UIView
    
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
    
    private lazy var leaveFeedback: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(leaveFeedbackButtonTapped)
        )
        button.setTitle(
            Strings.Localized.leaveFeedback.rawValue.localized(),
            for: .normal
        )
        button.setTitleColor(UIColor.greenColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = UIColor.whiteColor
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.greenColor.cgColor
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Cart block properties
    private let cartView: UIView
    
    private lazy var selectTypeStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor.lightGreyColor
        stack.layer.cornerRadius = 10
        stack.layer.masksToBounds = true
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var itemsButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(itemsButtonTapped)
        )
        button.setTitle(
            Strings.Localized.itemsLabel.rawValue.localized(),
            for: .normal
        )
        button.setTitleColor(UIColor.blackColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.backgroundColor = UIColor.whiteColor
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.lightGreyColor.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var weightButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(weightButtonTapped)
        )
        button.setTitle(
            Strings.Localized.weightLabel.rawValue.localized(),
            for: .normal
        )
        button.setTitleColor(UIColor.blackColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.backgroundColor = UIColor.lightGreyColor
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.lightGreyColor.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let price: Float = 55.9
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = String(price)
        label.textColor = .blackColor
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discount: Float = 199.0
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        let attributedLabel = NSMutableAttributedString(string: String(discount))
        attributedLabel.addAttributes(
            [NSAttributedString.Key.strikethroughStyle : 2],
            range: NSRange(location: 0, length: attributedLabel.length)
        )
        label.attributedText = attributedLabel
        label.textColor = .greyColor
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var unitsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Localized.currencyLabel.rawValue.localized()
        label.textAlignment = .left
        label.textColor = .blackColor
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Localized.weightLabel.rawValue.localized().lowercased()
        label.textAlignment = .right
        label.textColor = .blackColor
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var diagonalLineView: UIView = {
        let diagonal = DiagonalLineView()
        diagonal.backgroundColor = .clear
        diagonal.translatesAutoresizingMaskIntoConstraints = false
        return diagonal
    }()
    
    private lazy var cartButtonsView: UIView = {
        let stack = UIView()
        stack.backgroundColor = .greenColor
        stack.layer.cornerRadius = 20
        stack.layer.masksToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(minusButtonTapped)
        )
        button.setTitle(
            "-",
            for: .normal
        )
        button.setTitleColor(UIColor.whiteColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(plusButtonTapped)
        )
        button.setTitle(
            "+",
            for: .normal
        )
        button.setTitleColor(UIColor.whiteColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let itemsInCart: Int = 1
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = String(itemsInCart) +
        Strings.Common.space.rawValue +
        Strings.Localized.itemsLabel.rawValue.localized().lowercased()
        label.textAlignment = .center
        label.textColor = .whiteColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalPrice: Float = 120.0
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = String(totalPrice) +
        Strings.Common.space.rawValue +
        Strings.Localized.currencyLabel.rawValue.localized().uppercased()
        label.textAlignment = .center
        label.textColor = .whiteColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    init(
        navigationBar: UINavigationBar,
        itemView: UIView,
        descriptionView: UIView,
        feedbacksView: UIView,
        cartView: UIView
    ) {
        self.navigationBar = navigationBar
        self.itemView = itemView
        self.descriptionView = descriptionView
        self.feedbacksView = feedbacksView
        self.cartView = cartView
    }
    
    func setupSubviews() {
        configureConstraints()
    }
    
    // MARK: - Objective-C methods
    
    @objc
    private func backButtonTapped() { }
    
    @objc
    private func likeButtonTapped() { }
    
    @objc
    private func uploadButtonTapped() { }
    
    @objc
    private func catalogButtonTapped() { }
    
    @objc
    private func allFeaturesButtonTapped() { }
    
    @objc
    private func allFeedbacksButtonTapped() { }
    
    @objc
    private func leaveFeedbackButtonTapped() { }
    
    @objc
    private func itemsButtonTapped() { }
    
    @objc
    private func weightButtonTapped() { }
    
    @objc
    private func plusButtonTapped() { }
    
    @objc
    private func minusButtonTapped() { }
}

// MARK: - Configure constraints

private extension SparPresenter {
    
    func configureConstraints() {
        configureNavigarionBar()
        configureItemView()
        configureDescriptionView()
        configureFeedbacksView()
        configureCart()
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
        feedbacksView.addSubview(leaveFeedback)
        NSLayoutConstraint.activate([
            leaveFeedback.topAnchor.constraint(equalTo: feedbacksCollectionView.bottomAnchor, constant: 10),
            leaveFeedback.leadingAnchor.constraint(equalTo: feedbacksCollectionView.leadingAnchor, constant: 10),
            leaveFeedback.trailingAnchor.constraint(equalTo: feedbacksCollectionView.trailingAnchor, constant: -10),
            leaveFeedback.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCart() {
        cartView.addSubview(selectTypeStack)
        NSLayoutConstraint.activate([
            selectTypeStack.topAnchor.constraint(equalTo: cartView.topAnchor, constant: 10),
            selectTypeStack.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 10),
            selectTypeStack.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -10),
            selectTypeStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        selectTypeStack.addArrangedSubview(itemsButton)
        selectTypeStack.addArrangedSubview(weightButton)
        cartView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: selectTypeStack.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 20)
        ])
        cartView.addSubview(discountLabel)
        NSLayoutConstraint.activate([
            discountLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            discountLabel.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 20)
        ])
        cartView.addSubview(unitsStack)
        NSLayoutConstraint.activate([
            unitsStack.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            unitsStack.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
            unitsStack.widthAnchor.constraint(equalToConstant: 20),
            unitsStack.heightAnchor.constraint(equalToConstant: 20)
        ])
        unitsStack.addArrangedSubview(currencyLabel)
        unitsStack.addArrangedSubview(weightLabel)
        unitsStack.addSubview(diagonalLineView)
        NSLayoutConstraint.activate([
            diagonalLineView.topAnchor.constraint(equalTo: unitsStack.topAnchor),
            diagonalLineView.leadingAnchor.constraint(equalTo: unitsStack.leadingAnchor),
            diagonalLineView.trailingAnchor.constraint(equalTo: unitsStack.trailingAnchor),
            diagonalLineView.bottomAnchor.constraint(equalTo: unitsStack.bottomAnchor)
        ])
        cartView.addSubview(cartButtonsView)
        NSLayoutConstraint.activate([
            cartButtonsView.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            cartButtonsView.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -10),
            cartButtonsView.leadingAnchor.constraint(equalTo: cartView.centerXAnchor),
            cartButtonsView.bottomAnchor.constraint(equalTo: discountLabel.bottomAnchor),
            cartButtonsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        cartButtonsView.addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: cartButtonsView.topAnchor),
            minusButton.leadingAnchor.constraint(equalTo: cartButtonsView.leadingAnchor),
            minusButton.bottomAnchor.constraint(equalTo: cartButtonsView.bottomAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        cartButtonsView.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: cartButtonsView.topAnchor),
            plusButton.trailingAnchor.constraint(equalTo: cartButtonsView.trailingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: cartButtonsView.bottomAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        cartButtonsView.addSubview(counterLabel)
        NSLayoutConstraint.activate([
            counterLabel.bottomAnchor.constraint(equalTo: cartButtonsView.centerYAnchor),
            counterLabel.centerXAnchor.constraint(equalTo: cartButtonsView.centerXAnchor)
        ])
        cartButtonsView.addSubview(totalPriceLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: cartButtonsView.centerYAnchor),
            totalPriceLabel.centerXAnchor.constraint(equalTo: cartButtonsView.centerXAnchor)
        ])
    }
    
}
