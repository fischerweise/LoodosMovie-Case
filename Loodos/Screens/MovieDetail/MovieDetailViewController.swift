//
//  MovieDetailViewController.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    // MARK: Instance Variables
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var overviewLabel = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private var padding: CGFloat = 20
    
    // MARK: Initialization
    private let viewModel: MovieDetailViewModel!
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        setupScrollView()
        setupContentView()
        setupViewController()
        setupImageView()
        setupTitleLabel()
        setupOverviewLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewController()
    }
}

// MARK: - Configure UI
private extension MovieDetailViewController {
    func setupScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + padding)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func setupContentView() {
        contentView.frame.size = CGSize(width: view.frame.width, height: view.frame.height + padding)
        scrollView.addSubview(contentView)
    }
    
    func updateViewController() {
        titleLabel.text = viewModel.movieTitle
        overviewLabel.text = viewModel.overviewText
        imageView.kf.setImage(
            with: viewModel.posterURL,
            placeholder: UIImage(named: "movie-placeholder")!
        )
    }
    
    func setupViewController() {
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel.title
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            imageView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = viewModel.movieTitle
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding)
        ])
    }
    
    func setupOverviewLabel() {
        overviewLabel.textColor = .label
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .preferredFont(forTextStyle: .body)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overviewLabel)
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding)
        ])
    }
}
