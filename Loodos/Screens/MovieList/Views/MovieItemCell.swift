//
//  MovieItemCell.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit
import Kingfisher

final class MovieItemCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MovieItemCell.self)
    private lazy var imageView = UIImageView()
    private var viewModel: MovieItemViewModel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with viewModel: MovieItemViewModel) {
        self.viewModel = viewModel
        imageView.kf.setImage(
            with: viewModel.posterURL,
            placeholder: UIImage(named: "movie-placeholder")!
        )
    }
}

private extension MovieItemCell {
    func setupCell() {
        backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setupImageView() {
        imageView.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}
