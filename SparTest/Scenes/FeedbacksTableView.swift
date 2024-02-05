import UIKit
final class FeedbacksTableView: UITableView {
    
    private let dataSourceDelegate = FeedbacksTableViewDataSource()
    private let delegateDelegate = FeedbacksTableViewDelegate()
    
    private lazy var feedbacksTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .blue
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.frame = frame
        self.delegate = delegateDelegate
        self.dataSource = dataSourceDelegate
        self.register(FeedbacksTableViewCell.self, forCellReuseIdentifier: FeedbacksTableViewCell.cellReuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class FeedbacksTableViewDelegate: NSObject, UITableViewDelegate { }

final class FeedbacksTableViewDataSource: NSObject, UITableViewDataSource {
    
    struct Feedback {
        let name: String
        let date: Date
        let rating: Int
        let text: String
    }
    
    let feedbacksArray: [Feedback] = [
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне понравилась! Хочу, чтобы все добавки были такими"
        ),
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне понравилась! Хочу, чтобы все добавки были такими"
        ),
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне понравилась! Хочу, чтобы все добавки были такими"
        )
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedbacksTableViewCell.cellReuseIdentifier, for: indexPath) as? FeedbacksTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor.yellow
        cell.configureCell(
            leftLabel: "New text"
        )
        cell.selectionStyle = .none
        return cell
    }
}
