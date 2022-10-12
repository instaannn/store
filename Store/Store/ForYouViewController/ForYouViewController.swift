//
//  ForYouViewController.swift
//  Store
//
//  Created by Анна Сычева on 08.10.2022.
//

import UIKit

/// Экран подборки для вас
final class ForYouViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let whatNewLabelText = "Вот что нового"
        static let yourDeviseLabelText = "Ваши устройства"
        static let processedStatusLabelText = "Обрабатывается"
        static let sentStatusLabelText = "Отправлено"
        static let title = "Для вас"
        static let key = "avatar"
        static let imageNoFound = "No image found"
        static let recommendedLabelText = "Рекомендуется вам"
        static let showAllButtonTitle = "Показать все"
        static let newsTitleLabelText = "Получайте новости о своем заказе в режиме реального времени."
        static let newsSubTitleLabelText = "Включите уведомления, чтобы получать новости о своём заказе."
        static let badgeSystemName = "app.badge"
        static let appleAirpodImageViewName = "appleAirpod"
        static let orderTitleLabelText = "Ваш заказ отправлен"
        static let orderSubTitleLabelText = "1 товар, доставка завтра с 12 до 18"
        static let deliveredStatusLabelText = "Доставлено"
        static let chevronImageViewName = "chevron.forward"
        static let iPhoneImageViewName = "iphone"
        static let imageSizeForLargeState: CGFloat = 40
        static let imageRightMargin: CGFloat = 16
        static let imageBottomMarginForLargeState: CGFloat = 12
        static let imageBottomMarginForSmallState: CGFloat = 6
        static let imageSizeForSmallState: CGFloat = 32
        static let navBarHeightSmallState: CGFloat = 44
        static let navBarHeightLargeState: CGFloat = 96.5
        
    }
    
    // MARK: - Private visual components

    private lazy var scrollView = makeScrollView()
    private lazy var whatNewLabel = makeTitleBoldLabel(text: Constants.whatNewLabelText, yCoordinate: 20)
    private lazy var yourDeviseLabel = makeTitleBoldLabel(text: Constants.yourDeviseLabelText, yCoordinate: 469)
    private lazy var recommendedLabel = makeRecommendedLabel()
    private lazy var showAllButton = makeShowAllButton()
    private lazy var newsTitleLabel = makeNewsTitleLabel()
    private lazy var newsSubTitleLabel = makeNewsSubTitleLabel()
    private lazy var badgeImageView = makeBadgeImageView()
    private lazy var shadowView = makeShadowView()
    private lazy var yourOrderContainerView = makeYourOrderContainerView()
    private lazy var appleAirpodImageView = makeAppleAirpodImageView()
    private lazy var orderTitleLabel = makeOrderTitle()
    private lazy var orderSubTitleLabel = makeOrderSubTitleLabel()
    private lazy var progressView = makeProgressView()
    private lazy var processedStatusLabel = makeOrderStatusBoldLabel(
        text: Constants.processedStatusLabelText,
        xCoordinate: 16,
        width: 100
    )
    private lazy var sentStatusLabel = makeOrderStatusBoldLabel(
        text: Constants.sentStatusLabelText,
        xCoordinate: 175,
        width: 70
    )
    private lazy var deliveredStatusLabel = makeDeliveredStatusLabel()
    private lazy var bigChevronImageView = makeChevronImageView(xCoordinate: 340, yCoordinate: 37)
    private lazy var chevronImageView = makeChevronImageView(xCoordinate: 380, yCoordinate: 369)
    private lazy var iPhoneImageView = makeiPhoneImageView()
    private lazy var avatarImageView = makeAvatarImageView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .light
        tabBarController?.overrideUserInterfaceStyle = .light
        navigationController?.overrideUserInterfaceStyle = .light
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        overrideUserInterfaceStyle = .unspecified
        tabBarController?.overrideUserInterfaceStyle = .unspecified
        navigationController?.overrideUserInterfaceStyle = .unspecified
    }
    
    // MARK: - Private methods

    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Constants.navBarHeightSmallState
            let heightDifferenceBetweenStates = (Constants.navBarHeightLargeState - Constants.navBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Constants.imageSizeForSmallState / Constants.imageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        let sizeDiff = Constants.imageSizeForLargeState * (1.0 - factor)
        
        let yTranslation: CGFloat = {
            let maxYTranslation = Constants.imageBottomMarginForLargeState -
            Constants.imageBottomMarginForSmallState + sizeDiff
            return max(0,
                       min(
                        maxYTranslation,
                        (maxYTranslation - coeff * (Constants.imageBottomMarginForSmallState + sizeDiff))
                       ))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        avatarImageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    @objc private func openImagePickerControllerAction() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
}

// MARK: - SetupUI

private extension ForYouViewController {
    
    func setupUI() {
        addViews()
        
        setupNavigationController()
        avatarImageView.image = Storage.shared.checkAvatar(forKey: Constants.key)
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(whatNewLabel)
        scrollView.addSubview(yourDeviseLabel)
        scrollView.addSubview(recommendedLabel)
        scrollView.addSubview(showAllButton)
        scrollView.addSubview(newsTitleLabel)
        scrollView.addSubview(newsSubTitleLabel)
        scrollView.addSubview(badgeImageView)
        scrollView.addSubview(shadowView)
        scrollView.addSubview(yourOrderContainerView)
        yourOrderContainerView.addSubview(appleAirpodImageView)
        yourOrderContainerView.addSubview(orderTitleLabel)
        yourOrderContainerView.addSubview(orderSubTitleLabel)
        yourOrderContainerView.addSubview(progressView)
        yourOrderContainerView.addSubview(processedStatusLabel)
        yourOrderContainerView.addSubview(sentStatusLabel)
        yourOrderContainerView.addSubview(deliveredStatusLabel)
        yourOrderContainerView.addSubview(bigChevronImageView)
        scrollView.addSubview(chevronImageView)
        scrollView.addSubview(iPhoneImageView)
    }
    
    func setupNavigationController() {
        title = Constants.title
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.prefersLargeTitles = true
        navigationBar.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.rightAnchor.constraint(
                equalTo: navigationBar.rightAnchor,
                constant: -Constants.imageRightMargin
            ),
            avatarImageView.bottomAnchor.constraint(
                equalTo: navigationBar.bottomAnchor,
                constant: -Constants.imageBottomMarginForLargeState
            ),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageSizeForLargeState),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension ForYouViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ForYouViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print(Constants.imageNoFound)
            return
        }
        avatarImageView.image = image
        guard let data = image.pngData() else { return }
        Storage.shared.saveAvatar(image: data, forKey: Constants.key)
    }
}

// MARK: - UINavigationControllerDelegate

extension ForYouViewController: UINavigationControllerDelegate { }

// MARK: - Factory

private extension ForYouViewController {
    
    func makeTitleBoldLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.frame = CGRect(x: 20, y: yCoordinate, width: 270, height: 30)
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }

    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 414, height: 800)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }
    
    func makeRecommendedLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.recommendedLabelText
        label.textColor = .label
        label.frame = CGRect(x: 20, y: 280, width: 270, height: 30)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }
    
    func makeShowAllButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Constants.showAllButtonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.frame = CGRect(x: 302, y: 477, width: 95, height: 20)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }
    
    func makeNewsTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.newsTitleLabelText
        label.textColor = .label
        label.frame = CGRect(x: 102, y: 342, width: 270, height: 36)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }
    
    func makeNewsSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.newsSubTitleLabelText
        label.textColor = .secondaryLabel
        label.frame = CGRect(x: 102, y: 381, width: 270, height: 36)
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }
    
    func makeBadgeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.badgeSystemName)
        imageView.tintColor = .systemRed
        imageView.frame = CGRect(x: 33, y: 342, width: 36, height: 36)
        return imageView
    }
    
    func makeShadowView() -> UIView {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.frame = CGRect(x: 18, y: 70, width: 378, height: 140)
        return view
    }
    
    func makeYourOrderContainerView() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 18, y: 70, width: 378, height: 140)
        view.layer.cornerRadius = 15
        return view
    }
    
    func makeAppleAirpodImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.appleAirpodImageViewName)
        imageView.frame = CGRect(x: 20, y: 17, width: 49, height: 49)
        return imageView
    }
    
    func makeOrderTitle() -> UILabel {
        let label = UILabel()
        label.text = Constants.orderTitleLabelText
        label.textColor = .label
        label.frame = CGRect(x: 84, y: 15, width: 230, height: 18)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }
    
    func makeOrderSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.orderSubTitleLabelText
        label.textColor = .secondaryLabel
        label.frame = CGRect(x: 84, y: 41, width: 230, height: 18)
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }
    
    func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.frame = CGRect(x: 16, y: 90, width: 346, height: 10)
        progressView.setProgress(0.5, animated: true)
        progressView.progressTintColor = .systemGreen
        progressView.trackTintColor = .systemGray3
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        return progressView
    }
    
    func makeOrderStatusBoldLabel(text: String, xCoordinate: Int, width: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.frame = CGRect(x: xCoordinate, y: 114, width: width, height: 13)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }
    
    func makeDeliveredStatusLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.deliveredStatusLabelText
        label.textColor = .secondaryLabel
        label.frame = CGRect(x: 294, y: 114, width: 68, height: 13)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }
    
    func makeChevronImageView(xCoordinate: Int, yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.chevronImageViewName)
        imageView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 14, height: 14)
        imageView.tintColor = .systemGray3
        return imageView
    }
    
    func makeiPhoneImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.iPhoneImageViewName)
        imageView.frame = CGRect(x: 132, y: 543, width: 150, height: 175)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.key)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.imageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(openImagePickerControllerAction))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }
}
