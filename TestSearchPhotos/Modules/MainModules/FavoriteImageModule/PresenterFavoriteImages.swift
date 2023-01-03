//
//  PresenterFavoriteImages.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import Foundation

protocol PresenterFavoriteImagesDelegate: AnyObject {
    func presenterFavoriteImages(images: [Response.ViewModelImage])
    func presenterSplashError(error: Error)
}

class PresenterFavoriteImages {
    
    weak private var delegate: PresenterFavoriteImagesDelegate?
    
    private var unarchiver = NSKeyedUnarchiver.self
    
    func loadDataArray(completion: @escaping (Result<[Response.ViewModelImage], Error>) -> ()) {
         guard
             let objects = UserDefaults.standard.data(forKey: "FavoriteImagesArray")
         else {
             return
         }
         do {
             let archiveObject = try unarchiver.unarchiveTopLevelObjectWithData(objects) as? [Response.ViewModelImage]
             guard let array = archiveObject  else {
                 fatalError("loadDataArray - Can't get Array")
             }
             completion(.success(array))
         } catch {
             fatalError("loadDataArray - Can't encode data: \(error)")
         }
     }
    
    public func setViewDelegate(delegate: PresenterFavoriteImagesDelegate) {
        self.delegate = delegate
    }
    
    func showFavoritePhotos() {
        loadDataArray { result in
            switch result {
            case .success(let success):
                self.delegate?.presenterFavoriteImages(images: success)
            case .failure(let error):
                self.delegate?.presenterSplashError(error: error)
            }
        }
   }
}
