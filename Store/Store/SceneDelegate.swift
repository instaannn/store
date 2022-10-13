//
//  SceneDelegate.swift
//  Store
//
//  Created by Анна Сычева on 08.10.2022.
//

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        // здесь тоже нужно выносить в константу?
        if !Storage.shared.checkOnboarding(forKey: "key") {
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
