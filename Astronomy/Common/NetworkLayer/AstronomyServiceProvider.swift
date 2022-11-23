//
//  AstronomyServiceProvider.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import Foundation

enum AstronomyServiceProvider {
    case getAstronomyDetail
}

// NOTE: Did not create switch cases as there was only one api
extension AstronomyServiceProvider: Service {
    var baseURL: String {
        return "https://api.nasa.gov"
    }
    
    var path: String {
        return "/planetary/apod"
    }
    
    var parameters: [String: Any]? {
        // default params
        return ["api_key": "443"]
    }
    
    var method: ServiceMethod {
        return .get
    }
}
