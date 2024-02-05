import UIKit
final class FeedbacksCollectionView: UICollectionView {
    
    private let feedbacksArray: [Feedback] = [
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"
        ),
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"
        ),
        Feedback(
            name: "Александр В.",
            date: Date(),
            rating: 4,
            text: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"
        )
    ]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: flow)
        self.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
        self.register(FeedbacksCollectionViewCell.self, forCellWithReuseIdentifier: FeedbacksCollectionViewCell.cellReuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedbacksCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 235, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return sectionInsets
    }
    
}

extension FeedbacksCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedbacksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedbacksCollectionViewCell.cellReuseIdentifier,
            for: indexPath) as? FeedbacksCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let name: String = feedbacksArray[indexPath.row].name
        let date: String = feedbacksArray[indexPath.row].date.formatted
        let rating: Int = feedbacksArray[indexPath.row].rating
        let text: String = feedbacksArray[indexPath.row].text
        cell.configureCell(
            nameLabel: name,
            dateLabel: date,
            rating: rating,
            feedbackText: text
        )
        cell.layer.shadowColor = UIColor.blackColor.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        return cell
    }
}
