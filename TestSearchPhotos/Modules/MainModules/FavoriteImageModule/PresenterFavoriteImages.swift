//
//  PresenterFavoriteImages.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import Foundation
import RealmSwift

protocol FavoriteImageProtocol: AnyObject {
  func presentImage(images: [DetailImageModel])
}

protocol PresenterFavoriteImagesProtocol: AnyObject {
  func loadDataArray(completion: @escaping ([DetailImageModel]) -> Void)
  
  init(view: FavoriteImageProtocol)
}

class PresenterFavoriteImages: PresenterFavoriteImagesProtocol {
  
  private let realm = try? Realm()
  
  weak var view: FavoriteImageProtocol?
  
  required init(view: FavoriteImageProtocol) {
    self.view = view
  }
  
  func loadDataArray(completion: @escaping ([DetailImageModel]) -> Void) {
    let array = realm?.objects(RMDetailImageModel.self)
    var newArray: [DetailImageModel] = []
    array?.forEach({
      let image = DetailImageModel(id: $0.id,
                                   userName: $0.userName,
                                   location: $0.location,
                                   image: $0.image,
                                   createdImage: $0.createdImage,
                                   downloadsCount: $0.downloadsCount,
                                   isFavorite: $0.isFavorite)
      newArray.append(image)
    })
    
    completion(newArray)
  }
  
  func showFavoritePhotos() {
    loadDataArray { result in
      self.view?.presentImage(images: result)
    }
  }
}
