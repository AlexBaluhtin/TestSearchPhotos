//
//  PresenterImages.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 7.06.22.
//

import Moya
import UIKit

protocol ImagesViewProtocol: AnyObject {
    func presentImages(images: [Response.RandomImageModel.ImageModelElement])
    func presentSearchResults(images: Response.SearchImageModel.SearchResults)
    func presentError(error: Error)
}

protocol PresenterImagesProtocol: AnyObject {
    func getImages()
    func searchImages(query: String, page: String)
    
    init(view: ImagesViewProtocol,
         imagesService: ImagesServiceProtocol)
}

class PresenterImages: PresenterImagesProtocol {
    
    weak var view: ImagesViewProtocol?
    
    let imagesService: ImagesServiceProtocol
    
    required init(view: ImagesViewProtocol, imagesService: ImagesServiceProtocol) {
        self.view = view
        self.imagesService = imagesService
        
        getImages()
    }
    
    func getImages() {
        imagesService.getImages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(images):
                self.view?.presentImages(images: images)
            case .failure(let error):
                self.view?.presentError(error: error)
            }
        }
    }
    
    func searchImages(query: String, page: String) {
        imagesService.searchResult(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(images):
                self.view?.presentSearchResults(images: images)
            case .failure(let error):
                self.view?.presentError(error: error)
            }
        }
    }
}
