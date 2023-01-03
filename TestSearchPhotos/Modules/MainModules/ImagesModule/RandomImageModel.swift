//
//  ImageModel.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 7.06.22.
//

import Foundation

enum Response {
    
    enum SearchImageModel {
        
        struct SearchResults: Decodable {
            let total: Int
            let results: [UnsplashPhoto]
        }

        struct UnsplashPhoto: Decodable {
            let id: String?
            let created_at, updated_at: String?
            let width, height: Int?
            let color, blur_hash: String?
            let downloads: Int?
            let urls: Urls?
            let user: User?
        }
    }
    
    enum RandomImageModel {
        struct ImageModelElement: Codable {
            let id: String?
            let created_at, updated_at: String?
            let width, height: Int?
            let color, blur_hash: String?
            let downloads: Int?
            let urls: Urls?
            let user: User?
            let location: Location?
        }
    }
    
    struct Location: Codable {
        let name: String?
        let position: Positions?
    }

    struct Positions: Codable {
        let latitude: Float?
        let longitude: Float?
    }
    // MARK: - Urls
    struct Urls: Codable {
        let raw, full, regular, small: String?
        let thumb: String?
    }

    // MARK: - User
    struct User: Codable {
        let id: String?
        let updatedAt: Date?
        let username, name: String?
        let links: Links?
        let location: String?
    }
    
    struct Links: Codable {
        let portfolio: String?
    }
    
    @objc(_TtCO16TestSearchPhotos8Response14ViewModelImage)class ViewModelImage: NSObject, NSCoding {
        
        var id: String
        var userName: String
        var location: String
        var image: String
        var createdImage: String
        var downloadsCount: Int
        
        init(id: String, userName: String, location: String, image: String, createdImage: String, downloadsCount: Int) {
            self.id = id
            self.userName = userName
            self.location = location
            self.createdImage = createdImage
            self.image = image
            self.downloadsCount = downloadsCount
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(id, forKey: "id")
            coder.encode(userName, forKey: "userName")
            coder.encode(location, forKey: "location")
            coder.encode(createdImage, forKey: "createdImage")
            coder.encode(image, forKey: "image")
            coder.encode(downloadsCount, forKey: "downloadsCount")
        }
        
        required init?(coder: NSCoder) {
            id = coder.decodeObject(forKey: "id") as? String ?? ""
            userName = coder.decodeObject(forKey: "userName") as? String ?? ""
            location = coder.decodeObject(forKey: "location") as? String ?? ""
            image = coder.decodeObject(forKey: "image") as? String ?? ""
            createdImage = coder.decodeObject(forKey: "createdImage") as? String ?? ""
            downloadsCount = coder.decodeObject(forKey: "downloadsCount") as? Int ?? 0
        }
    }
}
