//
//  NetworkManager.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//
import Foundation

enum ServiceMethod: String {
    case get = "GET"
    // implement more when needed: post, put, delete, etc.
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not found")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        // If param is not given then return url without adding queryItems to it
        guard let parameters = parameters as? [String: String] else {
            return urlComponents?.url
        }
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents?.url
    }
}

