//
//  ProductViewController.swift
//  Store
//
//  Created by Анна Сычева on 09.10.2022.
//

import UIKit

/// Экран продукта
final class ProductViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let checkBoxImageViewName = "checkmark.circle.fill"
        static let deliveryBoxImageViewName = "shippingbox"
        static let addToCartButtonTitle = "Добавить в корзину"
        static let deliveryDateLabelText = """
        Заказ сегодня в течении дня, доставка:
        Чт 25 Фев - Бесплатно
        Варианты доставки для местоположения: 115533
        """
        static let compatibilityLabelText = "Совместимо с MacBook Pro — Евгений"
        static let rightBarButtonItemHeart = "heart"
        static let rightBarButtonItemSquare = "square.and.arrow.up"
        static let infoButtonImageViewName = "info.circle"
        static let pdfName = "Chistaya_arkhitektura"
        static let pdfExtension = "pdf"
    }
    
    // MARK: - Private visual Components
    
    private lazy var productNameLabel = makeProductNameLabel()
    private lazy var productPriceLabel = makeProductPriceLabel()
    private lazy var productNameSubtitleLabel = makeSecondaryLabel(yCoordinate: 474, width: 280, xCoordinate: 68)
    private lazy var compatibilityLabel = makeSecondaryLabel(yCoordinate: 622, width: 212, xCoordinate: 99)
    private lazy var addToCartButton = makeAddToCartButton()
    private lazy var deliveryDateLabel = makeDeliveryDateLabel()
    private lazy var deliveryBoxImageView = makeDeliveryBoxImageView()
    private lazy var checkBoxImageView = makeCheckBoxImageView()
    private lazy var lightGrayColorButton = makeColorButton(color: .systemGray, xCoordinate: 164)
    private lazy var darkGrayColorButton = makeColorButton(color: .tertiarySystemFill, xCoordinate: 213)
    private lazy var backgroungForButtonView = makeBackgroungForButtonView()
    private lazy var scrollView = UIScrollView()
    private lazy var infoButton = makeInfoButton()
    
    // MARK: - Public properties
    
    var product: Product?
    
    // MARK: - Private properties
    
    private var imageCount = 0
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        setupColorNavigationBar(onThisNavigation: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupColorNavigationBar(onThisNavigation: true)
    }
    
    // MARK: - Private methods

    @objc private func openWebViewControllerAction(_ sender: UITapGestureRecognizer) {
        guard let product = product else { return }
        goToWebViewController(url: product.url)
    }
    
    @objc private func infoButtonAction() {
        guard let url = Bundle.main.url(
            forResource: Constants.pdfName,
            withExtension: Constants.pdfExtension
        ) else { return }
        goToWebViewController(url: "\(url)")
    }
    
    private func goToWebViewController(url: String) {
        let webViewController = WebViewController()
        webViewController.urlString = url
        webViewController.modalPresentationStyle = .pageSheet
        present(webViewController, animated: true)
    }
}

// MARK: - SetupUI

private extension ProductViewController {
    
    func setupUI() {
        addViews()
        
        setupNavigationController()
        setupCompatibilityLabel()
        setupDeliveryDateLabel()
        setupProductNames()
        makeProductImageViews()
    }
    
    func addViews() {
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(productNameSubtitleLabel)
        view.addSubview(compatibilityLabel)
        view.addSubview(addToCartButton)
        view.addSubview(deliveryDateLabel)
        view.addSubview(deliveryBoxImageView)
        view.addSubview(checkBoxImageView)
        view.addSubview(lightGrayColorButton)
        view.addSubview(backgroungForButtonView)
        view.addSubview(darkGrayColorButton)
        view.addSubview(infoButton)
    }
    
    func setupNavigationController() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: Constants.rightBarButtonItemHeart),
                style: .plain,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                image: UIImage(systemName: Constants.rightBarButtonItemSquare),
                style: .plain,
                target: self,
                action: nil
            )
        ]
    }
    
    func setupColorNavigationBar(onThisNavigation: Bool) {
        let appearance = UINavigationBarAppearance()
        if onThisNavigation {
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .systemBackground
        } else {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .secondarySystemBackground
        }
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =
        navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.prefersLargeTitles = onThisNavigation
    }
    
    func setupCompatibilityLabel() {
        let myMutableString = NSMutableAttributedString(string: Constants.compatibilityLabelText)
        myMutableString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.systemBlue,
            range: NSRange(location: 13, length: 21)
        )
        compatibilityLabel.attributedText = myMutableString
    }
    
    func setupDeliveryDateLabel() {
        let myMutableString = NSMutableAttributedString(string: Constants.deliveryDateLabelText)
        myMutableString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.secondaryLabel,
            range: NSRange(location: 39, length: 22)
        )
        myMutableString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.systemBlue,
            range: NSRange(location: 61, length: 44)
        )
        deliveryDateLabel.attributedText = myMutableString
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor.systemBackground.cgColor
        let colorBottom = UIColor.systemGray2.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = darkGrayColorButton.bounds
        gradientLayer.cornerRadius = 17
        darkGrayColorButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupProductNames() {
        guard let product = product else { return }
        productNameLabel.text = product.name
        productNameSubtitleLabel.text = product.name
        productPriceLabel.text = product.price
    }
}

// MARK: - Factory

private extension ProductViewController {
    
    func makeProductNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.frame = CGRect(x: 14, y: 126, width: 387, height: 20)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }
    
    func makeProductImageViews() {
        var xCoordinate = 56
        guard let product = product else { return }
        imageCount = product.imageNames.count
        if imageCount > 0 {
            scrollView = makeScrollView()
        }
        for image in product.imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: xCoordinate, y: 31, width: 300, height: 200)
            let tap = UITapGestureRecognizer(target: self, action: #selector(openWebViewControllerAction))
            imageView.addGestureRecognizer(tap)
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            xCoordinate += 412
        }
    }
    
    func makeProductPriceLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.frame = CGRect(x: 133, y: 152, width: 150, height: 20)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }
    
    func makeSecondaryLabel(yCoordinate: Int, width: Int, xCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: 15)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }
    
    func makeAddToCartButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 9
        button.frame = CGRect(x: 12, y: 672, width: 390, height: 40)
        button.setTitle(Constants.addToCartButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }
    
    func makeDeliveryDateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.frame = CGRect(x: 50, y: 740, width: 300, height: 45)
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }
    
    func makeDeliveryBoxImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.deliveryBoxImageViewName)
        imageView.frame = CGRect(x: 16, y: 743, width: 17, height: 17)
        imageView.tintColor = .secondaryLabel
        return imageView
    }
    
    func makeCheckBoxImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.checkBoxImageViewName)
        imageView.frame = CGRect(x: 67, y: 620, width: 19, height: 19)
        imageView.tintColor = .systemGreen
        return imageView
    }
    
    func makeColorButton(color: UIColor, xCoordinate: Int) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: xCoordinate, y: 544, width: 34, height: 34)
        button.layer.cornerRadius = 17
        button.backgroundColor = color
        return button
    }
    
    func makeBackgroungForButtonView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.cornerRadius = 21
        view.frame = CGRect(x: 209, y: 540, width: 42, height: 42)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 192, width: view.bounds.width, height: 260))
        scrollView.contentMode = .scaleAspectFit
        scrollView.contentSize = CGSize(width: Int(scrollView.bounds.width) * imageCount, height: 260)
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        return scrollView
    }
    
    func makeInfoButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.infoButtonImageViewName), for: .normal)
        button.tintColor = .systemBlue
        button.frame = CGRect(x: 378, y: 743, width: 17, height: 17)
        button.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        return button
    }
}
