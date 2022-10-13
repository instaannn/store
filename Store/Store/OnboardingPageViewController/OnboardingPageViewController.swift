//
//  OnboardingPageViewController.swift
//  Store
//
//  Created by Анна Сычева on 12.10.2022.
//

import UIKit

/// Экран онбординга
final class OnboardingPageViewController: UIPageViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let firstImageName = "1"
        static let firstTitle = "re:Store"
        static let firstSubTitle = "Сеть магазинов re:Store входит в группу компаний Inventive Retail Group"
        static let secondImageName = "2"
        static let secondTitle = "Онлайн магазин"
        static let secondSubTitle = "Крупнейшая сеть магазинов и сервисных центров техники Apple"
        static let thirdImageName = "3"
        static let thirdTitle = "Бесплатная доставка"
        static let thirdSubTitle = "За прошедшие годы нашими клиентами стали сотни тысяч людей."
        static let onboardingKey = "key"
        static let skipButtonTitle = "SKIP"
        static let nextButtonTitle = "NEXT"
        static let getStartButtonTitle = "GET STARTED"
    }
    
    // MARK: - Private visual components
    
    private lazy var skipButton = makeSkipButton()
    private lazy var nextButton = makeNextButton()
    private lazy var getStartButton = makeGetStartButton()
    
    // MARK: - Private properties

    private var currentIndex = 0
    private let pageAppearance = UIPageControl.appearance()
    private var onboardingScreens = [
        Onboarding(
            imageName: Constants.firstImageName,
            title: Constants.firstTitle,
            subTitle: Constants.firstSubTitle
        ),
        Onboarding(
            imageName: Constants.secondImageName,
            title: Constants.secondTitle,
            subTitle: Constants.secondSubTitle
        ),
        Onboarding(
            imageName: Constants.thirdImageName,
            title: Constants.thirdTitle,
            subTitle: Constants.thirdSubTitle
        )
    ]
    private lazy var screenOnboardingViewControllers: [ScreenOnboardingViewController] = {
        var screenOnboardingViewControllers: [ScreenOnboardingViewController] = [ScreenOnboardingViewController]()
        for screen in onboardingScreens {
            screenOnboardingViewControllers.append(ScreenOnboardingViewController(model: screen))
        }
        return screenOnboardingViewControllers
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func togglePageControl(isHidden: Bool) {
        for subView in view.subviews where subView is UIPageControl {
            subView.isHidden = isHidden
        }
    }
    
    private func isLastViewController(index: Int) {
        if index == onboardingScreens.count - 1 {
            skipButton.isHidden = true
            nextButton.isHidden = true
            getStartButton.isHidden = false
            togglePageControl(isHidden: true)
        } else {
            skipButton.isHidden = false
            nextButton.isHidden = false
            getStartButton.isHidden = true
            togglePageControl(isHidden: false)
        }
    }
    
    @objc private func skipButtonAction() {
        Storage.shared.saveOnboarding(forKey: Constants.onboardingKey)
        let mainTabBar = MainTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        present(mainTabBar, animated: true)
    }
    
    @objc private func nextButtonAction() {
        guard let currentVC = viewControllers?.first,
              let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC) else { return }
        if nextVC == screenOnboardingViewControllers.last {
            skipButton.isHidden = true
            nextButton.isHidden = true
            getStartButton.isHidden = false
            togglePageControl(isHidden: true)
        }
        setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    @objc private func makeGetStartButtonAction() {
        Storage.shared.saveOnboarding(forKey: Constants.onboardingKey)
        let mainTabBar = MainTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        present(mainTabBar, animated: true)
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        guard let pendingViewController = pendingViewControllers.first,
              let screenOnboardingViewController = pendingViewController as? ScreenOnboardingViewController,
              let index = screenOnboardingViewControllers.firstIndex(of: screenOnboardingViewController) else { return }
        switch index {
        case screenOnboardingViewControllers.indices.last:
            isLastViewController(index: index)
        default:
            isLastViewController(index: index)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? ScreenOnboardingViewController,
              let index = screenOnboardingViewControllers.firstIndex(of: viewController),
              index > 0 else { return nil }
        currentIndex = index - 1
        return screenOnboardingViewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? ScreenOnboardingViewController,
              let index = screenOnboardingViewControllers.firstIndex(of: viewController),
              index < screenOnboardingViewControllers.count - 1 else { return nil }
        currentIndex = index + 1
        return screenOnboardingViewControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingScreens.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}

// MARK: - SetupUI

private extension OnboardingPageViewController {
    
    func setupUI() {
        addViews()
        setupPageController()
    }
    
    func addViews() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(getStartButton)
    }
    
    func setupPageController() {
        pageAppearance.pageIndicatorTintColor = .systemGray
        pageAppearance.currentPageIndicatorTintColor = .systemBlue
        setViewControllers([screenOnboardingViewControllers[0]], direction: .forward, animated: true)
        delegate = self
        dataSource = self
    }
}

// MARK: - Factory

private extension OnboardingPageViewController {
    
    func makeSkipButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Constants.skipButtonTitle, for: .normal)
        button.frame = CGRect(x: 89, y: 837, width: 44, height: 25)
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        return button
    }
    
    func makeNextButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Constants.nextButtonTitle, for: .normal)
        button.frame = CGRect(x: 281, y: 837, width: 50, height: 25)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }
    
    func makeGetStartButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Constants.getStartButtonTitle, for: .normal)
        button.frame = CGRect(x: 139, y: 837, width: 140, height: 30)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(makeGetStartButtonAction), for: .touchUpInside)
        return button
    }
}
