//
//  RandomImageModel.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 4.01.23.
//

import Foundation

enum RandomImageModel {
    
    struct ImageModelElement: Codable {
        let id: String?
        let createdAt, updatedAt: String?
        let width, height: Int?
        let color, blurHash: String?
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
