import UIKit

final class FeedbacksTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellReuseIdentifier = "feedbacksCell"
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let leftTextView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.backgroundColor = UIColor.clear
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(
        leftLabel: String
    ) {
        leftTextView.text = leftLabel
    }
    
    // MARK: - Configure constraints
    
    private func configureConstraints() {
        addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.widthAnchor.constraint(equalToConstant: 235),
            background.heightAnchor.constraint(equalToConstant: 150)
        ])
        addSubview(leftTextView)
        NSLayoutConstraint.activate([
            leftTextView.topAnchor.constraint(equalTo: topAnchor),
            leftTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftTextView.widthAnchor.constraint(equalToConstant: frame.width/2.1)
        ])
    }
}

