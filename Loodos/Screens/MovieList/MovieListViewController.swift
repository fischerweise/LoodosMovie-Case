//
//  MovieListViewController.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: Variables
    private lazy var loadingView = UIActivityIndicatorView(style: .medium)
    private lazy var searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var timer: Timer?
    private let viewModel: MovieListViewModel!
    
    init(viewModel: MovieListViewModel = MovieListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        setupSearchController()
        setupCollectionView()
        setupNavigationBar()
        setupLoadingView()
    }
}

// MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    func willUpdateViewController() {
        updateViewController()
    }
    
    func willUpdateViewController(with message: String) {
        updateViewController()
        presentAlertOnMainThread(
            title: viewModel.errorTitle,
            message: message,
            buttonTitle: viewModel.alertButtonTitle
        )
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            viewModel.emptyList()
            return
        }
        loadingView.startAnimating()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] timer in
            self?.viewModel.searchMovies(with: searchText)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.didSelectItemAt(indexPath: indexPath)
        let movieItem = viewModel.cellForItemAt(indexPath: indexPath)
        let movieDetailViewModel = MovieDetailViewModel(movie: movieItem)
        let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieItemCell.reuseIdentifier,
            for: indexPath
        ) as! MovieItemCell
        let movieItem = viewModel.cellForItemAt(indexPath: indexPath)
        cell.populateCell(with: MovieItemViewModel(movie: movieItem))
        return cell
    }
}

// MARK: - Configure UI
private extension MovieListViewController {
    func updateViewController() {
        DispatchQueue.main.async { [self] in
            loadingView.stopAnimating()
            collectionView.reloadData()
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Type a movie name to search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.returnKeyType = .done
        navigationItem.searchController = searchController
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.title
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIManager.createThreeColumnFlowLayout(in: view)
        )
        collectionView.register(
            MovieItemCell.self,
            forCellWithReuseIdentifier: MovieItemCell.reuseIdentifier
        )
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .label
        
        collectionView.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 200),
            loadingView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
    }
}
