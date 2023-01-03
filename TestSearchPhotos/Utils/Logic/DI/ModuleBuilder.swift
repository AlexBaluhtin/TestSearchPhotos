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
}
