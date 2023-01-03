//
//  ImagesService.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 3.01.23.
//

import Foundation

protocol ImagesServiceProtocol: AnyObject {
    
    func getImages(completion: @escaping (Result<[Response.RandomImageModel.ImageModelElement], Error>) -> ())
    func searchResult(query: String,
                      page: String,
                      completion: @escaping (Result<Response.SearchImageModel.SearchResults, Error>) -> ())
}

final class ImagesService: ImagesServiceProtocol {
    
    private var apiClient = MoyaRestClient<ImagesTarget>()
    
    func getImages(completion: @escaping (Result<[Response.RandomImageModel.ImageModelElement], Error>) -> ()) {
        apiClient.sendRequest(to: .fetchRandomPhotos(count: 30)) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
    
    func searchResult(query: String,
                      page: String,
                      completion: @escaping (Result<Response.SearchImageModel.SearchResults, Error>) -> ()) {
        apiClient.sendRequest(to: .searchPhotos(query: query,
                                                page: page,
                                                perPage: String(30))) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }

    }
    
}