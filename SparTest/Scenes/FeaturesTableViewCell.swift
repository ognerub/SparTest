import UIKit

final class FeaturesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellReuseIdentifier = "cell"
    
    private let dotLabel: UILabel = {
        let label = UILabel()
        label.text = "........................................................................................................................."
        label.textAlignment = .center
        label.textColor = UIColor.blackColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftTextView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.textColor = UIColor.blackColor
        text.backgroundColor = UIColor.clear
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let rightTextView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.textColor = UIColor.blackColor
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
        rightLabel: String,
        leftLabel: String
    ) {
        leftTextView.text = leftLabel
        rightTextView.text = rightLabel
        highlightFrom(textView: leftTextView, text: leftLabel)
        highlightFrom(textView: rightTextView, text: rightLabel)
        rightTextView.textAlignment = .right
    }
    
    private func highlightFrom(textView: UITextView, text: String) {
        let attributedText = NSMutableAttributedString(string: textView.text)
        let range = (textView.text as NSString).range(of: text, options: .caseInsensitive)
        if range.location != NSNotFound {
            attributedText.addAttribute(.backgroundColor, value: UIColor.whiteColor, range: range)
        }
        textView.attributedText = attributedText
    }
    
    // MARK: - Configure constraints
    
    private func configureConstraints() {
        addSubview(dotLabel)
        NSLayoutConstraint.activate([
            dotLabel.topAnchor.constraint(equalTo: topAnchor),
            dotLabel.heightAnchor.constraint(equalToConstant: 30),
            dotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        addSubview(leftTextView)
        NSLayoutConstraint.activate([
            leftTextView.topAnchor.constraint(equalTo: topAnchor),
            leftTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftTextView.widthAnchor.constraint(equalToConstant: frame.width/2.1)
        ])
        addSubview(rightTextView)
        NSLayoutConstraint.activate([
            rightTextView.topAnchor.constraint(equalTo: topAnchor),
            rightTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightTextView.widthAnchor.constraint(equalToConstant: frame.width/1.9)
        ])
    }
}

