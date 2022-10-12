//
//  MainTabBarController.swift
//  Store
//
//  Created by Анна Сычева on 08.10.2022.
//
import UIKit

/// ТабБарКонтроллер
final class MainTabBarController: UITabBarController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buyViewControllerTitle = "Купить"
        static let buyViewControllerTabBarItemImageName = "laptopcomputer.and.iphone"
        static let forYouViewControllerTitle = "Для вас"
        static let forYouViewControllerTabBarItemImageName = "person.circle"
        static let searchNavigationControllerTitle = "Поиск"
        static let searchNavigationControllerTabBarItemImageName = "magnifyingglass"
        static let cartViewControllerTitle = "Корзина"
        static let cartViewControllerTabBarItemImageName = "bag"
    }
    
    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        let buyViewController = BuyViewController()
        let forYouViewController = ForYouViewController()
        let forYouNavigationController = UINavigationController(rootViewController: forYouViewController)
        let searchViewController = SearchViewController()
        let cartViewController = CartViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        buyViewController.tabBarItem = UITabBarItem(
            title: Constants.buyViewControllerTitle,
            image: UIImage(systemName: Constants.buyViewControllerTabBarItemImageName),
            selectedImage: UIImage(systemName: Constants.buyViewControllerTabBarItemImageName)
        )
        forYouNavigationController.tabBarItem = UITabBarItem(
            title: Constants.forYouViewControllerTitle,
            image: UIImage(systemName: Constants.forYouViewControllerTabBarItemImageName),
            selectedImage: UIImage(systemName: Constants.forYouViewControllerTabBarItemImageName)
        )
        searchNavigationController.tabBarItem = UITabBarItem(
            title: Constants.searchNavigationControllerTitle,
            image: UIImage(systemName: Constants.searchNavigationControllerTabBarItemImageName),
            selectedImage: UIImage(systemName: Constants.searchNavigationControllerTabBarItemImageName)
        )
        cartViewController.tabBarItem = UITabBarItem(
            title: Constants.cartViewControllerTitle,
            image: UIImage(systemName: Constants.cartViewControllerTabBarItemImageName),
            selectedImage: UIImage(systemName: Constants.cartViewControllerTabBarItemImageName)
        )
        
        tabBar.backgroundColor = .secondarySystemBackground
        
        viewControllers = [
            buyViewController,
            forYouNavigationController,
            searchNavigationController,
            cartViewController
        ]
    }
}
