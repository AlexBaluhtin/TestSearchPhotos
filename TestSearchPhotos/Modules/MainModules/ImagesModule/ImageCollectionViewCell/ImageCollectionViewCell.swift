//
//  ImageCollectionViewCell.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 7.06.22.
//

import SDWebImage
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    private var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.makeShadow()
        return view
    }()
    
    private lazy var imagePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 20
        addSubviews()
        self.contentView.isUserInteractionEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePhoto.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageView()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(imagePhoto)
    }
    
    func configure(viewModel: Response.ViewModelImage) {
        
        guard let url = URL(string: viewModel.image) else { return }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.imagePhoto.sd_setImage(with: url, completed: nil)
        }
        contentView.layer.cornerRadius = 20
    }
    
    private func setupImageView() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imagePhoto.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imagePhoto.topAnchor.constraint(equalTo: containerView.topAnchor),
            imagePhoto.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imagePhoto.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
