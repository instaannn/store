//
//  WebViewController.swift
//  Store
//
//  Created by Анна Сычева on 10.10.2022.
//

import UIKit
import WebKit

/// Экран вебвью
final class WebViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let backButtonItemName = "chevron.left"
        static let forwardButtonItemName = "chevron.right"
        static let shareButtonItemName = "square.and.arrow.up"
    }
    
    // MARK: - Private visual Components
    
    private lazy var webView = WKWebView()
    private lazy var toolBar = UIToolbar()
    private lazy var backButtonItem = makeButtonItem(systemName: Constants.backButtonItemName)
    private lazy var forwardButtonItem = makeButtonItem(systemName: Constants.forwardButtonItemName)
    private lazy var spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    private lazy var refreshButtonItem = UIBarButtonItem(systemItem: .refresh)
    private lazy var shareButtonItem = makeButtonItem(systemName: Constants.shareButtonItemName)
    private lazy var progressView = UIProgressView(progressViewStyle: .default)
    private lazy var progressViewItem = UIBarButtonItem(customView: progressView)
    
    // MARK: - Private properties
    
    private var observation: NSKeyValueObservation?
    
    // MARK: - Public properties
    
    var urlString = ""
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setObserve()
        setupUI()
        sendRequest(urlString: urlString)
    }
    
    // MARK: - Private methods

    private func sendRequest(urlString: String) {
        guard let myURL = URL(string: urlString) else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    private func setObserve() {
        observation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.progressView.progress = Float(self.webView.estimatedProgress)
            if self.progressView.progress == 1.0 {
                self.progressView.isHidden = true
            }
        }
    }
    
    @objc private func backButtonAction() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    @objc private func forwardButtonAction() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }

    @objc private func refreshButtonAction() {
        webView.reload()
    }

    @objc private func shareButtonAction() {
        let activityViewController = UIActivityViewController(
            activityItems: [urlString],
            applicationActivities: nil
        )
        present(activityViewController, animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButtonItem.isEnabled = webView.canGoBack
        forwardButtonItem.isEnabled = webView.canGoForward
    }
}

// MARK: - SetupUI

private extension WebViewController {
    
    func setupUI() {
        view.backgroundColor = .red
        view = webView
        view.addSubview(toolBar)
        toolBar.items = [
            backButtonItem,
            forwardButtonItem,
            spacer,
            progressViewItem,
            spacer,
            refreshButtonItem,
            shareButtonItem
        ]
        webView.navigationDelegate = self
        toolBar.frame = CGRect(x: 0, y: 780, width: 414, height: 44)
        backButtonItem.action = #selector(backButtonAction)
        forwardButtonItem.action = #selector(forwardButtonAction)
        refreshButtonItem.action = #selector(refreshButtonAction)
        shareButtonItem.action = #selector(shareButtonAction)
    }
}

// MARK: - Fatory

private extension WebViewController {
    
    func makeButtonItem(systemName: String) -> UIBarButtonItem {
        let backButtonItem = UIBarButtonItem(
            image: UIImage(systemName: systemName),
            style: .plain,
            target: self,
            action: nil
        )
        return backButtonItem
    }
}
