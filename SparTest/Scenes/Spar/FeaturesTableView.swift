import UIKit
final class FeaturesTableView: UITableView {
    
    private let featuresArray: [Feature] = [
        Feature(
            name: Strings.Localized.feature01key.rawValue,
            value: Strings.Localized.feature01value.rawValue
        ),
        Feature(
            name: Strings.Localized.feature02key.rawValue,
            value: Strings.Localized.feature02value.rawValue
        ),
        Feature(
            name: Strings.Localized.feature03key.rawValue,
            value: Strings.Localized.feature03value.rawValue
        ),
        Feature(
            name: Strings.Localized.feature04key.rawValue,
            value: Strings.Localized.feature04value.rawValue
        ),
        Feature(
            name: Strings.Localized.feature05key.rawValue,
            value: Strings.Localized.feature05value.rawValue
        ),
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.register(FeaturesTableViewCell.self, forCellReuseIdentifier: FeaturesTableViewCell.cellReuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeaturesTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesTableViewCell.cellReuseIdentifier, for: indexPath) as? FeaturesTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor.whiteColor
        let leftText: String = featuresArray[indexPath.row].value.localized()
        let rightText: String = featuresArray[indexPath.row].name.localized()
        cell.configureCell(
            rightLabel: leftText,
            leftLabel: rightText
        )
        cell.selectionStyle = .none
        return cell
    }
}
