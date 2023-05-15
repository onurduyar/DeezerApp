//
//  APIRequest.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation

protocol APIRequest: DataRequest {
    associatedtype Response
    
    var baseURL: String { get }
    var url: String { get }
    var method: HTTPMethod { get }
}
extension APIRequest {
    var baseURL: String {
        "https://api.deezer.com"
    }
    var url: String{
        ""
    }
    var method: HTTPMethod {
        .get
    }
    
}

