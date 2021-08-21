//  Created by Ky Nguyen

import UIKit

class MainTabController: UITabBarController {
    private(set) lazy var homeController = HomeController()
    private(set) lazy var searchController = SearchController()
    private(set) lazy var activitiesController = ActivitiesController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        hidesBottomBarWhenPushed = true
        tabBar.barTintColor = UIColor(hex: "#1F2024")
        tabBar.tintColor = .white
        
        setupTabItem(for: homeController, icon: #imageLiteral(resourceName: "home_active"))
        setupTabItem(for: searchController, icon: #imageLiteral(resourceName: "search_active"))
        setupTabItem(for: activitiesController, icon: #imageLiteral(resourceName: "activities_active"))
        
        var controllers: [UIViewController] = []
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        homeNavigationController.isNavigationBarHidden = true
        controllers.append(homeNavigationController)
        controllers.append(homeNavigationController)
        
        let searchNavigationController = UINavigationController(rootViewController: searchController)
        searchNavigationController.isNavigationBarHidden = true
        controllers.append(searchNavigationController)
        
        let activitiesNavigationController = UINavigationController(rootViewController: activitiesController)
        activitiesNavigationController.isNavigationBarHidden = true
        controllers.append(activitiesNavigationController)
        
        viewControllers = controllers
        tabBar.isTranslucent = false
    }
    
    private func setupTabItem(for controller: UIViewController, icon: UIImage?) {
        controller.tabBarItem = UITabBarItem(title: nil, image: icon, selectedImage: icon)
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.itemPositioning = .fill
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // update tab bar y position
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabFrame.size.height + 5
        tabFrame.origin.y = view.frame.size.height - tabFrame.size.height
        tabBar.frame = tabFrame
    }

}
