//
//  RestClient.swift
//  SpyApp
//
//  Created by mac on 1.12.21.
//

import Foundation

protocol RestClient {
  
  associatedtype Endpoint
  
  /// Отправка сетевого запроса в конечную точку веб-службы
  /// - Parameters:
  ///   - endpoint: конечная точка веб-службы, в которую отправляется запрос
  ///   - success: обработчик завершения, вызывается после получения успешного ответа (200...299) и его декодирования
  ///   - failure: обработчик завершения, вызывается после получения ошибочного ответа или невозможности декодирования
  func sendRequest<T: Decodable>(to endpoint: Endpoint,
                                 success successCallback: @escaping (T) -> Void,
                                 failure failureCallback: @escaping (NetworkError) -> Void)
}

extension RestClient {
  
  func decodeClientError(data: Data, failureCallback: @escaping (NetworkError) -> Void) {
    do {
      let decodedError = try JSONDecoder().decode(CustomError.self, from: data)
      failureCallback(.customError(error: decodedError))
    } catch {
      failureCallback((.unableToDecode))
    }
  }
}
