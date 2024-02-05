import UIKit

final class FeedbacksCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let cellReuseIdentifier = "feedbacksCell"
    
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.whiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.blackColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.greyColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let image = UIImage.ratingStars
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var feedbackText: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.textColor = UIColor.blackColor
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(
        nameLabel: String,
        dateLabel: String,
        rating: Int,
        feedbackText: String
    ) {
        self.nameLabel.text = nameLabel
        self.dateLabel.text = dateLabel
        self.feedbackText.text = feedbackText
    }
    
    // MARK: - Configure constraints
    
    private func configureConstraints() {
        addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        addSubview(ratingImageView)
        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            ratingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ratingImageView.widthAnchor.constraint(equalToConstant: 96),
            ratingImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        addSubview(feedbackText)
        NSLayoutConstraint.activate([
            feedbackText.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 5),
            feedbackText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            feedbackText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

