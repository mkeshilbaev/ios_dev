//
//  DetailViewController.swift
//  BrowserApp
//
//  Created by Madi Keshilbayev on 25.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    var website: Website!
    var dataManager: DataManager!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWebsite()
    }

    private func loadWebsite() {
        if let url = website?.url {
            webView.load(URLRequest(url: url)) 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = self.view.center
    }
    
    private func setNavigationItem() {
        navigationItem.title = website?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addWebsiteToFavourites))
    }
    
    @objc private func addWebsiteToFavourites() {
        dataManager.addToFavourites(website: website)
        showAddToFavouritesAlert()
    }
    
    private func showAddToFavouritesAlert() {
        let alert = UIAlertController(title: "Favourites", message: "You've successfully added website to favourites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}



