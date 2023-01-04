//
//  ModuleBuilder.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 3.01.23.
//

import UIKit

protocol Builder {
  static func createTabBarController() -> UIViewController
  static func createImagesModule(flowLayout: UICollectionViewFlowLayout) -> UIViewController
  static func createInfoImage(image: DetailImageModel) -> UIViewController
  static func createFavoriteImagesModule() -> UIViewController
}

class ModulBuilder: Builder {
  
  static func createTabBarController() -> UIViewController {
    let view = TabBarViewController()
    return view
  }
  
  static func createImagesModule(flowLayout: UICollectionViewFlowLayout) -> UIViewController {
    let view = ImagesViewController(collectionViewLayout: flowLayout)
    let imagesService = ImagesService()
    let presenter = PresenterImages(view: view,
                                    imagesService: imagesService)
    view.presenter = presenter
    return view
  }
  
  static func createInfoImage(image: DetailImageModel) -> UIViewController {
    let view = InfoImageViewController(image: image)
    let favoriteImageService = FavoriteImageService()
    let presenter = PresenterInfoImage(view: view,
                                       favoriteImageService: favoriteImageService)
    view.presenter = presenter
    return view
  }
  
  static func createFavoriteImagesModule() -> UIViewController {
    let view = FavoriteViewController()
    let presenter = PresenterFavoriteImages(view: view)
    view.presenter = presenter
    return view
  }
}
