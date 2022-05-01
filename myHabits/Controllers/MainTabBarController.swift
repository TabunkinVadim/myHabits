//
//  MainTabBarController.swift
//  myHabits
//
//  Created by Табункин Вадим on 03.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        view.tintColor = UIColor(named: "Purple Color")
    }

    func setupTabBar() {
        let habitsViewController = createNavController(viewController: HabitsViewController(), itemName: "Привычки", itemImage: "rectangle.grid.1x2.fill")
        let infoViewController = createNavController(viewController: InfoViewController(), itemName: "Информация", itemImage: "info.circle.fill")
        viewControllers = [habitsViewController, infoViewController]
    }

    func createNavController(viewController:UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 0, left: 0, bottom: 0, right: 0)), tag: 0 )
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: -3 )
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        return navController
    }
}

