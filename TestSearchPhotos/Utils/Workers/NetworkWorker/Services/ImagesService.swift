//
//  ImagesService.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 3.01.23.
//

import Foundation

protocol ImagesServiceProtocol: AnyObject {
  
  /// Метод, который загружает рандомные фото из интернета
  func getImages(completion: @escaping (Result<[RandomImageModel.ImageModelElement], Error>) -> Void)
  
  /// Метод, который загружает фото из интернета по параметрам
  func searchResult(query: String,
                    page: String,
                    completion: @escaping (Result<SearchImageModel.SearchResults, Error>) -> Void)
}

final class ImagesService: ImagesServiceProtocol {
  
  private var apiClient = MoyaRestClient<ImagesTarget>()
  
  func getImages(completion: @escaping (Result<[RandomImageModel.ImageModelElement], Error>) -> Void) {
    apiClient.sendRequest(to: .fetchRandomPhotos(count: 30)) { result in
      completion(.success(result))
    } failure: { error in
      completion(.failure(error))
    }
  }
  
  func searchResult(query: String,
                    page: String,
                    completion: @escaping (Result<SearchImageModel.SearchResults, Error>) -> Void) {
    apiClient.sendRequest(to: .searchPhotos(query: query,
                                            page: page,
                                            perPage: String(30))) { result in
      completion(.success(result))
    } failure: { error in
      completion(.failure(error))
    }
  }
}
