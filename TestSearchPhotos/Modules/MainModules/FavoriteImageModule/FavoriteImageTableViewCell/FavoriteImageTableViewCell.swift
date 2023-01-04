//
//  FavoriteImageTableViewCell.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import SDWebImage
import UIKit

class FavoriteImageTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FavoriteImageTableViewCell"
    
    private var imagePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        selectionStyle = .none
        backgroundColor = .white
    }
    
    func configure(_ image: DetailImageModel) {
        guard let url = URL(string: image.image ?? "") else { return }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.imagePhoto.sd_setImage(with: url, completed: nil)
        }
        userNameLabel.text = image.userName
    }
    
    private func setup() {
        contentView.addSubview(imagePhoto)
        contentView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            imagePhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imagePhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagePhoto.heightAnchor.constraint(equalToConstant: 50),
            imagePhoto.widthAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 16),
            userNameLabel.centerYAnchor.constraint(equalTo: imagePhoto.centerYAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
