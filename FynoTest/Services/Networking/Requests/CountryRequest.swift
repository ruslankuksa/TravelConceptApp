//
//  CountryRequest.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 28.06.2024.
//

import NetRunner

struct CountryRequest: NetworkRequest {
    
    let url: String = "https://restcountries.com/v3.1"
    let method: HTTPMethod = .get
    let endpoint: Endpoint
    
    var headers: HTTPHeaders? = nil
    var httpBody: (any Encodable)? = nil
    
    var parameters: Parameters? {
        return [
            "status": true,
            "fields": "name,flag,location,latlng"
        ]
    }
    
    init(endpoint: CountryEndpoint) {
        self.endpoint = endpoint
    }
}
