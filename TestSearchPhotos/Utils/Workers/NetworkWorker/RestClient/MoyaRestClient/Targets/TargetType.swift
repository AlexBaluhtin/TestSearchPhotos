//
//  RestClient.swift
//  SpyApp
//
//  Created by mac on 1.12.21.
//

import Moya

extension TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.unsplash.com/")!
    }
    
    var sampleData: Data {
        Data()
    }
    
    var headers: [String: String]? {
        ["Authorization": "Client-ID 7AYgvmpdMJBES-Wewj5_yIjoKUWkWm5y5f-W_vZ1KWY"]
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}
