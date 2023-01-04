//
//  RestClient.swift
//  SpyApp
//
//  Created by mac on 1.12.21.
//

import Moya

final class MoyaRestClient<Target: TargetType>: RestClient {
  typealias Endpoint = Target
  
  private var provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin()])
  
  func sendRequest<T: Decodable>(to endpoint: Target,
                                 success: @escaping (T) -> Void,
                                 failure: @escaping (NetworkError) -> Void) {
    provider.request(endpoint) { result in
      switch result {
      case .success(let response):
        do {
          let decodedObject = try response.map(T.self)
          success(decodedObject)
        } catch {
          failure(.unableToDecode)
        }
      case .failure(let error):
        if let response = error.response {
          self.decodeClientError(data: response.data, failureCallback: failure)
        } else {
          failure(.serverError)
        }
      }
    }
  }
}
