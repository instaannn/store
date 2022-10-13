//
//  ScreenOnboardingViewController.swift
//  Store
//
//  Created by Анна Сычева on 12.10.2022.
//

import UIKit

/// Экран одной страницы онбординга
final class ScreenOnboardingViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let darkVioletColor = "darkViolet"
    }
    
    // MARK: - Private visual components
    
    private lazy var backgroungImageView = makeBackgroungImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    
    // MARK: - Private properties

    private let onboarding: Onboarding
    
    init(model: Onboarding) {
        self.onboarding = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UILabel.animate(withDuration: 2) {
            self.setAlpha(number: 1)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setAlpha(number: 0)
    }
    
    // MARK: - Private methods

    private func setAlpha(number: CGFloat) {
        titleLabel.alpha = number
        subtitleLabel.alpha = number
    }
}

// MARK: - SetupUI

private extension ScreenOnboardingViewController {
    
    func setupUI() {
        view.addSubview(backgroungImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
}

// MARK: - Factory

private extension ScreenOnboardingViewController {
    
    func makeBackgroungImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.image = UIImage(named: onboarding.imageName)
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = onboarding.title
        label.textColor = UIColor(named: Constants.darkVioletColor)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.frame = CGRect(x: 47, y: 640, width: 320, height: 40)
        label.alpha = 0
        return label
    }
    
    func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.text = onboarding.subTitle
        label.textColor = UIColor(named: Constants.darkVioletColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.frame = CGRect(x: 56, y: 697, width: 300, height: 80)
        label.alpha = 0
        return label
    }
}
