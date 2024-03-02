//
//  TransitionScreenViewController.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit

final class TransitionScreenViewController: UIViewController {
    private lazy var loadingView = UIActivityIndicatorView(style: .medium)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        setupLoadingView()
    }
}

private extension TransitionScreenViewController {
    func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .label
        loadingView.startAnimating()
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
