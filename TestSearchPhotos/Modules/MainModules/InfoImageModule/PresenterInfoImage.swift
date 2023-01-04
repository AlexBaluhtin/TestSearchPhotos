//
//  PresenterInfoImage.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import RealmSwift
import UIKit

protocol InfoImageProtocol: AnyObject {
  func presentImage(image: DetailImageModel)
  func getFavoriteImages(images: [DetailImageModel])
}

protocol PresenterInfoImageProtocol: AnyObject {
  func addImageInFavorite(image: DetailImageModel)
  func removeImageForFavorite(image: DetailImageModel)
  func showImage(image: DetailImageModel)
  func loadDataArray()
  
  init(view: InfoImageProtocol,
       favoriteImageService: FavoriteImageServiceProtocol)
}

class PresenterInfoImage: PresenterInfoImageProtocol {
  
  let favoriteImageService: FavoriteImageServiceProtocol
  weak var view: InfoImageProtocol?
  
  required init(view: InfoImageProtocol,
                favoriteImageService: FavoriteImageServiceProtocol ) {
    self.view = view
    self.favoriteImageService = favoriteImageService
    
    loadDataArray()
  }
  
  func loadDataArray() {
    favoriteImageService.loadDataArray { result in
      self.view?.getFavoriteImages(images: result)
    }
  }
  
  func addImageInFavorite(image: DetailImageModel) {
    favoriteImageService.saveFavoriteImage(image: image)
  }
  
  func removeImageForFavorite(image: DetailImageModel) {
    favoriteImageService.removeFavoriteImage(image: image)
  }
  
  func showImage(image: DetailImageModel) {
    self.view?.presentImage(image: image)
  }
}
