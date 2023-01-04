//
//  InfoImageView.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import SDWebImage
import UIKit

protocol InfoImageViewDelegate: AnyObject {
  func addInFavoritePhoto(image: DetailImageModel)
  func removeForFavoritePhoto(image: DetailImageModel)
}

protocol InfoImageViewLogic: UIView {
  func configure(image: DetailImageModel)
  
  var delegate: InfoImageViewDelegate? { get set }
}

final class InfoImageView: UIView {
  
  weak var delegate: InfoImageViewDelegate?
  
  // MARK: - Private properties
  private var image: DetailImageModel?
  
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
  
  lazy var favoritePhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 10
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(clicledFavoritePhoto), for: .touchUpInside)
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
  
  func configure(image: DetailImageModel) {
    
    guard let url = URL(string: image.image) else { return }
    
    self.image = image
    imagePhoto.sd_setImage(with: url, completed: nil)
    nameUserLabel.text = "Имя автора: \(image.userName)"
    createdAtLabel.text = "Дата создания: \(image.createdImage)"
    countDownloadsLabel.text = "Количество скачиваний: \(image.downloadsCount)"
    locationLabel.text = "Местоположение: \(image.location)"
    
    if image.isFavorite {
      favoritePhotoButton.tag = 0
      favoritePhotoButton.setTitle("Удалить из избранного", for: .normal)
      favoritePhotoButton.backgroundColor = .red
      favoritePhotoButton.setTitleColor(.white, for: .normal)
    } else {
      favoritePhotoButton.tag = 1
      favoritePhotoButton.backgroundColor = .green
      favoritePhotoButton.setTitle("Добавить в избранное", for: .normal)
      favoritePhotoButton.setTitleColor(.black, for: .normal)
    }
    
  }
  
  // MARK: - Selectors methods
  @objc func clicledFavoritePhoto() {
    guard let image = self.image else { return }
    
    switch favoritePhotoButton.tag {
    case 0:
      delegate?.removeForFavoritePhoto(image: image)
    case 1:
      delegate?.addInFavoritePhoto(image: image)
    default:
      break
    }
  }
  
  // MARK: - Private methods
  
  private func setupSubviews() {
    addSubview(imagePhoto)
    addSubview(nameUserLabel)
    addSubview(createdAtLabel)
    addSubview(countDownloadsLabel)
    addSubview(locationLabel)
    addSubview(favoritePhotoButton)
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
      favoritePhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      favoritePhotoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      favoritePhotoButton.heightAnchor.constraint(equalToConstant: 52),
      favoritePhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - InfoImageViewLogic

extension InfoImageView: InfoImageViewLogic {
  
}
