import UIKit
final class TabBarController: UITabBarController {
    private let mainTabBarItem = UITabBarItem(
        title: Strings.Localized.mainLabel.rawValue.localized(),
        image: UIImage.tabBarItem0,
        tag: 0
    )
    private let catalogTabBarItem = UITabBarItem(
        title: Strings.Localized.catalogLabel.rawValue.localized(),
        image: UIImage.tabBarItem1,
        tag: 1
    )
    private let cartTabBarItem = UITabBarItem(
        title: Strings.Localized.cartLabel.rawValue.localized(),
        image: UIImage.tabBarItem2,
        tag: 2
    )
    private let profileTabBarItem = UITabBarItem(
        title: Strings.Localized.profileLabel.rawValue.localized(),
        image: UIImage.tabBarItem3,
        tag: 3
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainViewController = SparViewController()
        mainViewController.tabBarItem = mainTabBarItem
        
        let catalogViewController = SparViewController()
        catalogViewController.tabBarItem = catalogTabBarItem
        
        let cartViewController = SparViewController()
        cartViewController.tabBarItem = cartTabBarItem
        
        let profileViewController = SparViewController()
        profileViewController.tabBarItem = profileTabBarItem

        viewControllers = [
            mainViewController,
            catalogViewController,
            cartViewController,
            profileViewController
        ]
        selectedIndex = 0

        view.backgroundColor = UIColor.whiteColor
        tabBar.backgroundColor = UIColor.whiteColor
        tabBar.tintColor = UIColor.greenColor
        tabBar.unselectedItemTintColor = UIColor.blackColor
    }
}

