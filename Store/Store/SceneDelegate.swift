//
//  SceneDelegate.swift
//  Store
//
//  Created by Анна Сычева on 08.10.2022.
//

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Constants
    
    private enum Constants {
        static let onboardingKey = "key"
    }
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        if !Storage.shared.checkOnboarding(forKey: Constants.onboardingKey) {
            window?.rootViewController = OnboardingPageViewController(
                transitionStyle: .scroll,
                navigationOrientation: .horizontal
            )
        } else {
            window?.rootViewController = MainTabBarController()
        }
        
        window?.makeKeyAndVisible()
    }
}
