//
//  PresenterInfoImage.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 8.06.22.
//

import UIKit

protocol PresenterInfoImageDelegate: AnyObject {
    func presenterFavoriteImages(images: [Response.ViewModelImage])
    func presenterSplashError(error: Error)
}

class PresenterInfoImage {
    
    weak private var delegate: PresenterInfoImageDelegate?
    
    private var unarchiver = NSKeyedUnarchiver.self
    
    func loadDataArray(completion: @escaping (Result<[Response.ViewModelImage], Error>) -> ()) {
         guard
             let objects = UserDefaults.standard.data(forKey: "FavoriteImagesArray")
         else {
             return
         }
         do {
             guard let array = try unarchiver.unarchiveTopLevelObjectWithData(objects) as? [Response.ViewModelImage] else {
                 fatalError("loadDataArray - Can't get Array")
             }
             completion(.success(array))
         } catch {
             fatalError("loadDataArray - Can't encode data: \(error)")
         }
     }
//    private  func getRandomImages(completion: @escaping (Result<[Response.ImageModel.ImageModelElement], Error>) -> ()) {
//        apiClient.sendRequest(to: .fetchRandomPhotos(count: 30)) { version in
//            completion(.success(version))
//        } failure: { error in
//            completion(.failure(error))
//        }
//    }
    
    public func setViewDelegate(delegate: PresenterInfoImageDelegate) {
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
