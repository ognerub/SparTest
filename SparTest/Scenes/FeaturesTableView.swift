import UIKit
final class FeaturesTableView: UITableView {
    
    private let dataSourceDelegate = FeaturesTableViewDataSource()
    private let delegateDelegate = FeaturesTableViewDelegate()
    
    private lazy var featuresTable: UITableView = {
        let table = UITableView()
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
        self.register(FeaturesTableViewCell.self, forCellReuseIdentifier: FeaturesTableViewCell.cellReuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class FeaturesTableViewDelegate: NSObject, UITableViewDelegate { }

final class FeaturesTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let featuresDictionary: [String: String] = [
        "01.Производитель" : "Россия, Краснодарский край",
        "02.Энергетическая ценность, ккал/100г" : "25 ккал, 105 кДж",
        "03.Жиры/100г" : "0,1г",
        "04.Белки/100г" : "1,3г",
        "05.Углеводы/100г" : "3,3г"
    ]
    
    private lazy var sortedFeaturesDictionary: [(String, String)] = {
        let array = featuresDictionary.sorted { $0.key < $1.key }
        return array
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesTableViewCell.cellReuseIdentifier, for: indexPath) as? FeaturesTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor.whiteColor
        let featureValue = sortedFeaturesDictionary[indexPath.row].1
        let leftText: String = featureValue
        let featureKey = sortedFeaturesDictionary[indexPath.row].0
        let cuttedFeatureKey = String(featureKey.suffix(featureKey.count-3))
        let rightText: String = cuttedFeatureKey
        cell.configureCell(
            rightLabel: leftText,
            leftLabel: rightText
        )
        cell.selectionStyle = .none
        return cell
    }
}
