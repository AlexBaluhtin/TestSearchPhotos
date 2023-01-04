//
//  RestClient.swift
//  SpyApp
//
//  Created by mac on 1.12.21.
//

import Foundation

enum NetworkError: Error, LocalizedError {
  case customError(error: CustomError)
  case serverError
  case noInternetConnection
  case unableToDecode
  case unauthorized
  
  var errorDescription: String? {
    switch self {
    case .serverError:
      return "Ошибка сервера"
    case .unableToDecode:
      return "Не удалось декодировать структуру"
    case .customError(let error):
      return error.message
    case .noInternetConnection:
      return "Нет подключения к Интернет"
    case .unauthorized:
      return "Не авторизирован"
    }
  }
}

struct CustomError: Error, Codable {
  var message: String
  var code: Int
}
