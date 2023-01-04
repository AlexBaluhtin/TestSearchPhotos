//
//  SearchImageModel.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 4.01.23.
//

import Foundation

enum SearchImageModel {
    
    struct SearchResults: Decodable {
        let total: Int
        let results: [UnsplashPhoto]
    }

    struct UnsplashPhoto: Decodable {
        let id: String?
        let createdAt, updatedAt: String?
        let width, height: Int?
        let color, blurHash: String?
        let downloads: Int?
        let urls: Urls?
        let user: User?
    }
}
