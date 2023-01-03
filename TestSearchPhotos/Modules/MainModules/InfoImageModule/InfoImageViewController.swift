//
//  InfoImageViewController.swift
//  TestImages
//
//  Created by Alex Balukhtsin on 6.06.22.
//

import UIKit

class InfoImageViewController: UIViewController {
    
    var viewModelImage: Response.ViewModelImage?
    
    lazy var contentView: InfoImageViewLogic = InfoImageView()
    private var favoriteImages: [Response.ViewModelImage] = []
    private var presenter = PresenterInfoImage()
    // MARK: - Lifecycle
    deinit {

    }
    
    override func loadView() {
      view = contentView
      contentView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter.setViewDelegate(delegate: self)
        presenter.showFavoritePhotos()
        guard let viewModelImage = viewModelImage else {
            return
        }

        contentView.configure(viewModel: viewModelImage)
    }
    
    private func setupNavigationBar() {
        title = "Info"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - GamePhoneViewLogic

extension InfoImageViewController: InfoImageViewDelegate {
    func addInFavoritePhoto(viewModel: Response.ViewModelImage) {
        let image = Response.ViewModelImage(id: viewModel.id,
                                            userName: viewModel.userName,
                                            location: viewModel.location,
                                            image: viewModel.image,
                                            createdImage: viewModel.createdImage,
                                            downloadsCount: viewModel.downloadsCount)
        
        if favoriteImages.contains(where: { $0.id == image.id }) {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Такая картинка уже добавлена в избранное",
                                          preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            favoriteImages.append(image)
            let userDefaults = UserDefaults.standard
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: favoriteImages, requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: "FavoriteImagesArray")
            userDefaults.synchronize()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func removeForFavoritePhoto(viewModel: Response.ViewModelImage) {
        
        if favoriteImages.contains(where: { $0.id == viewModel.id }) {
            let alert = UIAlertController(title: nil,
                                          message: "Вы точно хотите удалить это фото из избранного?",
                                          preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                
                self.favoriteImages = self.favoriteImages.filter({ $0.id != viewModel.id })
                let userDefaults = UserDefaults.standard
                let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: self.favoriteImages,
                                                                    requiringSecureCoding: false)
                userDefaults.set(encodedData, forKey: "FavoriteImagesArray")
                userDefaults.synchronize()
                self.navigationController?.popViewController(animated: true)
            })
            let cancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension InfoImageViewController: PresenterInfoImageDelegate {
    func presenterFavoriteImages(images: [Response.ViewModelImage]) {
        self.favoriteImages = images
    }
    
    func presenterSplashError(error: Error) {
        
    }
}
