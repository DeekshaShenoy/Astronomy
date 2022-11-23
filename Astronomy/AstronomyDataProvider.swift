//
//  AstronomyDataProvider.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import Foundation

typealias AstronomyDecoderResponse = (AstronomyResponse?, Error?)
typealias AstronomyCompletionHandler = (AstronomyResponse?, Error?) -> Void

class AstronomyDataProvider {
    let provider = ServiceProvider<AstronomyServiceProvider>()
    
    
    /// Fetch astronomy Information api
    func loadAstronomyInfo(completionHandler: @escaping AstronomyCompletionHandler) {
        provider.load(service: .getAstronomyDetail) { result in
            switch result {
            case .success(let responseData):
                let json = self.nsdataToJSON(data: responseData)
                print("decoder JSON Response", json)

                let decoderResponse = self.decodeAstronomyResponse(data: responseData)
                print("decoderResponse", decoderResponse)
                completionHandler(decoderResponse.0, decoderResponse.1)
            case .failure(let error):
                print(error.localizedDescription)
            case .empty:
                print("No data")
            }
        }
    }
    
    func nsdataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    func decodeAstronomyResponse(data: Data) -> AstronomyDecoderResponse {
        let decoder = JSONDecoder()
        do {
            let astronomyModel = try decoder.decode(AstronomyResponse.self, from: data)
            return (astronomyModel, nil)
        } catch {
            print("error in decoding")
            // TODO: Construct an error
            return (nil, nil)
        }
    }
}
