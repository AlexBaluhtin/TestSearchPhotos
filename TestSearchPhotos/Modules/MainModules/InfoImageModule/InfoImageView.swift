//
//  InfoImageView.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import SDWebImage
import UIKit

protocol InfoImageViewDelegate: AnyObject {
    func addInFavoritePhoto(viewModel: Response.ViewModelImage)
    func removeForFavoritePhoto(viewModel: Response.ViewModelImage)
}

protocol InfoImageViewLogic: UIView {
    func configure(viewModel: Response.ViewModelImage)
    
    var delegate: InfoImageViewDelegate? { get set }
}

final class InfoImageView: UIView {
    
    weak var delegate: InfoImageViewDelegate?
    
    // MARK: - Private properties
    private var viewModelImage: Response.ViewModelImage?
    
    private  lazy var imagePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let countDownloadsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
     lazy var addFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить в избранное", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .green
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addInFavoritePhoto), for: .touchUpInside)
        return button
    }()
    
     lazy var removeForFavoritePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить из избранного", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .red
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeForFavoritePhoto), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
        setupImage()
        setupLabels()
        setupButtons()
    }
    
    // MARK: - Public methods
    
    func configure(viewModel: Response.ViewModelImage) {
        guard let url = URL(string: viewModel.image) else { return }
        self.viewModelImage = viewModel
        imagePhoto.sd_setImage(with: url, completed: nil)
        nameUserLabel.text = "Имя автора: \(viewModel.userName)"
        createdAtLabel.text = "Дата создания: \(viewModel.createdImage)"
        countDownloadsLabel.text = "Количество скачиваний: \(viewModel.downloadsCount)"
        locationLabel.text = "Местоположение: \(viewModel.location )"
    }
    
    // MARK: - Selectors methods
    @objc func removeForFavoritePhoto() {
        guard let image = self.viewModelImage else { return }
        delegate?.removeForFavoritePhoto(viewModel: image)
    }
    
    @objc func addInFavoritePhoto() {
        guard let image = self.viewModelImage else { return }
        delegate?.addInFavoritePhoto(viewModel: image)
    }
    // MARK: - Private methods
    
    private func setupSubviews() {
        addSubview(imagePhoto)
        addSubview(nameUserLabel)
        addSubview(createdAtLabel)
        addSubview(countDownloadsLabel)
        addSubview(locationLabel)
        addSubview(removeForFavoritePhotoButton)
        addSubview(addFavoriteButton)
    }
        
    private func setupImage() {
        NSLayoutConstraint.activate([
            imagePhoto.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imagePhoto.trailingAnchor.constraint(equalTo: trailingAnchor),
            imagePhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupLabels() {
        NSLayoutConstraint.activate([
            nameUserLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameUserLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameUserLabel.topAnchor.constraint(equalTo: imagePhoto.bottomAnchor, constant: 16),
            
            createdAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createdAtLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createdAtLabel.topAnchor.constraint(equalTo: nameUserLabel.bottomAnchor, constant: 10),
            
            countDownloadsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countDownloadsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countDownloadsLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 10),
            
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: countDownloadsLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupButtons() {
        NSLayoutConstraint.activate([
            removeForFavoritePhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            removeForFavoritePhotoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            removeForFavoritePhotoButton.heightAnchor.constraint(equalToConstant: 52),
            removeForFavoritePhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            addFavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addFavoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 52),
            addFavoriteButton.bottomAnchor.constraint(equalTo: removeForFavoritePhotoButton.topAnchor, constant: -13),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - InfoImageViewLogic

extension InfoImageView: InfoImageViewLogic {
  
}
