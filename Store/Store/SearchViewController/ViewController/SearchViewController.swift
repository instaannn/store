//
//  SearchViewController.swift
//  Store
//
//  Created by Анна Сычева on 08.10.2022.
//

import UIKit

/// Экран поиска товаров
final class SearchViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let systemName = "magnifyingglass"
        static let recentlyWatchedLabelText = "Недавно просмотренные"
        static let requestOptionsLabelText = "Варианты запросов"
        static let requestOptions = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
        static let title = "Поиск"
        static let searchBarPlaceholderText = "Поиск по продуктам и магазинам"
        static let clearButtonTitle = "Очистить"
        static let caseBlackName = "Чехол Incase Flat для MacBook Pro 16 дюймов"
        static let caseBlackImageNames = ["caseBlackFront", "caseBlack2", "caseBlack3"]
        static let caseBlackPrice = "3 990.00 руб."
        static let sportStrapName = "Спортивный ремешок Black Unity (для занятий спортом)"
        static let sportStrapImageNames = ["sportStrap", "sportStrap2"]
        static let sportStrapPrice = "2 990.00 руб."
        static let caseBrownName = "Кожаный чехол для MacBook Pro, 16 дюймов, золотой"
        static let caseBrownImageNames = ["caseBrownFront", "caseBrown2", "caseBrown3"]
        static let caseBrownPrice = "3 990.00 руб."
        static let iPhoneName = "iPhone 12 pro Max"
        static let iPhoneImageNames = ["iphone", "iphoneFull"]
        static let iPhonePrice = "333 990.00 руб."
    }
    
    // MARK: - Private visual Components
    
    private lazy var serchBar = makeSearchBar()
    private lazy var recentlyWatchedLabel = makeBoldLabel(text: Constants.recentlyWatchedLabelText, yCoordinate: 224)
    private lazy var clearButton = makeClearButton()
    private lazy var requestOptionsLabel = makeBoldLabel(text: Constants.requestOptionsLabelText, yCoordinate: 499)
    private lazy var scrollView = makeScrollView()
    
    // MARK: - Private properties

    private let products = [
        Product(
            name: Constants.caseBlackName,
            imageNames: Constants.caseBlackImageNames,
            price: Constants.caseBlackPrice
        ),
        Product(
            name: Constants.sportStrapName,
            imageNames: Constants.sportStrapImageNames,
            price: Constants.sportStrapPrice
        ),
        Product(
            name: Constants.caseBrownName,
            imageNames: Constants.caseBrownImageNames,
            price: Constants.caseBrownPrice
        ),
        Product(
            name: Constants.iPhoneName,
            imageNames: Constants.iPhoneImageNames,
            price: Constants.iPhonePrice
        )
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func openProductViewControllerAction(_ sender: UITapGestureRecognizer) {
        guard let selectView = sender.view,
              selectView.tag < products.count else { return }
        let productViewController = ProductViewController()
        productViewController.product = products[selectView.tag]
        navigationController?.pushViewController(productViewController, animated: true)
    }
}

// MARK: - SetupUI

private extension SearchViewController {
    
    func setupUI() {
        view.addSubview(serchBar)
        view.addSubview(recentlyWatchedLabel)
        view.addSubview(clearButton)
        view.addSubview(requestOptionsLabel)
        view.addSubview(scrollView)
        
        setupNavigationController()
        makeRequestOptions(yCoordinateConstant: 51)
        makeProductView()
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.title
    }
}

// MARK: - Factory

private extension SearchViewController {
    
    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 10, y: 146, width: 394, height: 38)
        searchBar.placeholder = Constants.searchBarPlaceholderText
        searchBar.setImage(UIImage(systemName: Constants.systemName), for: .search, state: .normal)
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func makeBoldLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.frame = CGRect(x: 21, y: yCoordinate, width: 282, height: 30)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }
    
    func makeClearButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Constants.clearButtonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.frame = CGRect(x: 310, y: 231, width: 85, height: 20)
        return button
    }
    
    func makeRegularLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.frame = CGRect(x: 60, y: yCoordinate, width: 335, height: 24)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    func makeSearchImageView(yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.systemName)
        imageView.tintColor = .secondaryLabel
        imageView.frame = CGRect(x: 33, y: yCoordinate, width: 15, height: 15)
        return imageView
    }
    
    func makeSeparatorView(yCoordinate: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        view.frame = CGRect(x: 19, y: yCoordinate, width: 376, height: 1)
        return view
    }
    
    func makeRequestOptions(yCoordinateConstant: Int) {
        var yCoordinateLabel = 545
        var yCoordinateImageView = 549
        var yCoordinateSeparatorView = 581
        for requestOption in Constants.requestOptions {
            let label = makeRegularLabel(text: requestOption, yCoordinate: yCoordinateLabel)
            let imageView = makeSearchImageView(yCoordinate: yCoordinateImageView)
            let separatorView = makeSeparatorView(yCoordinate: yCoordinateSeparatorView)
            [label, imageView, separatorView].forEach { view.addSubview($0) }
            yCoordinateLabel += yCoordinateConstant
            yCoordinateImageView += yCoordinateConstant
            yCoordinateSeparatorView += yCoordinateConstant
        }
    }
    
    func makeProductBackgroundView(xCoordinate: Int, tag: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.frame = CGRect(x: xCoordinate, y: 269, width: 138, height: 187)
        view.layer.cornerRadius = 15
        view.tag = tag
        let tap = UITapGestureRecognizer(target: self, action: #selector(openProductViewControllerAction))
        view.addGestureRecognizer(tap)
        return view
    }
    
    func makeProductImageView(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 19, y: 15, width: 100, height: 100)
        return imageView
    }
    
    func makeProductNameLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.frame = CGRect(x: 7, y: 127, width: 124, height: 45)
        return label
    }
    
    func makeProductView() {
        var xCoordinateBackgroundView = 21
        for (index, product) in products.enumerated() {
            let productBackgroundView = makeProductBackgroundView(xCoordinate: xCoordinateBackgroundView, tag: index)
            let productImageView = makeProductImageView(named: product.imageNames.first ?? "")
            let productNameLabel = makeProductNameLabel(text: product.name)
            scrollView.addSubview(productBackgroundView)
            [productImageView, productNameLabel].forEach { productBackgroundView.addSubview($0) }
            xCoordinateBackgroundView += 147
        }
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 609, height: 187)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
}
