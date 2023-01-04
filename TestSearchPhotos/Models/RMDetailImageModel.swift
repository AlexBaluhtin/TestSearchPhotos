//
//  RMDetailImageModel.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 4.01.23.
//

import RealmSwift

@objcMembers class RMDetailImageModel: Object {
  dynamic var id: String = ""
  dynamic var userName: String = ""
  dynamic var location: String = ""
  dynamic var image: String = ""
  dynamic var createdImage: String = ""
  dynamic var downloadsCount: Int = 0
  dynamic var isFavorite: Bool = false
  
  convenience init(image: DetailImageModel) {
    self.init()
    self.id = image.id
    self.userName = image.userName
    self.location = image.location
    self.image = image.image
    self.createdImage = image.createdImage
    self.downloadsCount = image.downloadsCount
    self.isFavorite = image.isFavorite
  }
  
  override class func primaryKey() -> String? {
    return #keyPath(RMDetailImageModel.id)
  }
}
