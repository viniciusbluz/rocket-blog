//
//  LoadingView.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class LoadingView: UIViewController {
    var isLoading: Bool! {
        didSet {
            if isLoading {
                loadingView.isHidden = false
                loadingView.backgroundColor = loadingView.backgroundColor?.withAlphaComponent(0.5)
                loadingActivityIndicator.startAnimating()
            } else {
                loadingView.isHidden = true
                loadingActivityIndicator.stopAnimating()
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewHierarchy()
        setupViewConstraints()
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let loadingView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondaryLabel
        contentView.isHidden = true
        contentView.isOpaque = true
        return contentView
    }()
    
    private let loadingActivityIndicator: UIActivityIndicatorView = {
        let loadingActivityIndicator = UIActivityIndicatorView()
        loadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingActivityIndicator.style = .large
        return loadingActivityIndicator
    }()
    
    func setupViewHierarchy() {
        view.addSubview(loadingView)
        loadingView.addSubview(loadingActivityIndicator)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    func showLoadingView(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.4, delay: 0.1) {
            self.loadingView.alpha = 1
            self.isLoading = true
        }
    }
    
    func dismissLoadingView() {
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut) {
            self.loadingView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
            self.isLoading = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading = false
    }
}

