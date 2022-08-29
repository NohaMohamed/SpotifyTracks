//
//  LoadingView.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 21/08/2022.
//

import Foundation
import UIKit

protocol LoadingViewCapable {
    func showLoading()
    func hideLoading()
}

extension LoadingViewCapable where Self: UIViewController {
    
    func showLoading() {
        let loader = LoadingView.shared
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.view.addSubview(loader)
            self.view.bringSubviewToFront(loader)
            loader.translatesAutoresizingMaskIntoConstraints = false
            loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
            loader.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        let loader = LoadingView.shared
        DispatchQueue.main.async {
            loader.removeFromSuperview()
        }
    }
}

class LoadingView: UIView {
    
     var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .cyan
        activityIndicator.color = .cyan
        return activityIndicator
    }()
    
    private init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addSubview(activityIndicator)
        backgroundColor = .clear
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let shared = LoadingView()
}
