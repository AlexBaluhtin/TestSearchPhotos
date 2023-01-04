//
//  FavoriteImageService.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 4.01.23.
//

import RealmSwift

protocol FavoriteImageServiceProtocol: AnyObject {
  func loadDataArray(completion: @escaping ([DetailImageModel]) -> Void)
  
  func saveFavoriteImage(image: DetailImageModel)
  
  func removeFavoriteImage(image: DetailImageModel)
}

final class FavoriteImageService: FavoriteImageServiceProtocol {
  
  private let realm = try? Realm()
  
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
  
  func saveFavoriteImage(image: DetailImageModel) {
    let image = RMDetailImageModel(image: image)
    
    do {
      try realm?.write {
        realm?.add(image, update: .all)
      }
    } catch {
      fatalError("ERROR")
    }
  }
  
  func removeFavoriteImage(image: DetailImageModel) {
    guard let array = realm?.objects(RMDetailImageModel.self) else { return }
    let image = array.first { $0.id == image.id }
    if let image = image {
      do {
        try realm?.write {
          realm?.delete(image)
        }
      } catch {
        fatalError("ERROR DELETING CHAT")
      }
    }
  }
}
