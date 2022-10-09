//
//  ProductViewController.swift
//  Store
//
//  Created by Анна Сычева on 09.10.2022.
//

import UIKit

/// Экран продукта
final class ProductViewController: UIViewController {
    
    // MARK: - Private visual Components
    
    private lazy var productNameLabel = makeProductNameLabel()
    private lazy var productImage = makeProductImageView()
    
    // MARK: - Public properties
    
    var imageName = ""
    var name = ""
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
}

// MARK: - SetupUI

private extension ProductViewController {
    
    func setupUI() {
        view.addSubview(productNameLabel)
        view.addSubview(productImage)
    }
}

// MARK: - Factory

private extension ProductViewController {
    
    func makeProductNameLabel() -> UILabel {
        let label = UILabel()
        label.text = name
        label.textColor = .label
        label.frame = CGRect(x: 14, y: 126, width: 387, height: 20)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }
    
    func makeProductImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 56, y: 223, width: 300, height: 200)
        return imageView
    }
}
