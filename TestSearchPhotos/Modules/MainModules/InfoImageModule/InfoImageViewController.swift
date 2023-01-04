//
//  InfoImageViewController.swift
//  TestImages
//
//  Created by Alex Balukhtsin on 6.06.22.
//

import UIKit

class InfoImageViewController: UIViewController {
  
  var image: DetailImageModel
  
  lazy var contentView: InfoImageViewLogic = InfoImageView()
  private var favoriteImages: [DetailImageModel] = []
  var presenter: PresenterInfoImageProtocol!
  
  // MARK: - Init
  init(image: DetailImageModel) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Lifecycle
  
  override func loadView() {
    view = contentView
    contentView.delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.showImage(image: self.image)
  }
  
  private func setupNavigationBar() {
    title = "Info"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
  }
}

// MARK: - GamePhoneViewLogic

extension InfoImageViewController: InfoImageViewDelegate {
  func addInFavoritePhoto(image: DetailImageModel) {
    
    let newImage = DetailImageModel(id: image.id,
                                    userName: image.userName,
                                    location: image.location,
                                    image: image.image,
                                    createdImage: image.createdImage,
                                    downloadsCount: image.downloadsCount,
                                    isFavorite: true)
    
    if favoriteImages.contains(where: { $0.id == newImage.id }) {
      let alert = UIAlertController(title: "Ошибка",
                                    message: "Такая картинка уже добавлена в избранное",
                                    preferredStyle: .alert)
      
      let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alert.addAction(cancel)
      present(alert, animated: true, completion: nil)
    } else {
      presenter.addImageInFavorite(image: newImage)
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func removeForFavoritePhoto(image: DetailImageModel) {
    let newImage = DetailImageModel(id: image.id,
                                    userName: image.userName,
                                    location: image.location,
                                    image: image.image,
                                    createdImage: image.createdImage,
                                    downloadsCount: image.downloadsCount,
                                    isFavorite: false)
    
    if favoriteImages.contains(where: { $0.id == newImage.id }) {
      let alert = UIAlertController(title: nil,
                                    message: "Вы точно хотите удалить это фото из избранного?",
                                    preferredStyle: .alert)
      
      let ok = UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
        guard let self = self else { return }
        
        self.presenter.removeImageForFavorite(image: newImage)
        
        self.navigationController?.popViewController(animated: true)
      })
      let cancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
      alert.addAction(ok)
      alert.addAction(cancel)
      present(alert, animated: true, completion: nil)
    }
  }
}

extension InfoImageViewController: InfoImageProtocol {
  func getFavoriteImages(images: [DetailImageModel]) {
    self.favoriteImages = images
  }
  
  func presentImage(image: DetailImageModel) {
    if favoriteImages.contains(where: { $0.id == image.id }) {
      if let image = favoriteImages.first(where: { $0.id == image.id }) {
        contentView.configure(image: image)
      }
    } else {
      contentView.configure(image: image)
    }
  }
}
