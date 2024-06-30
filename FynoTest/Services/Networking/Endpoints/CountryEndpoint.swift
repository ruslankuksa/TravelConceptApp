//
//  CountryEndpoint.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 28.06.2024.
//

import NetRunner

enum CountryEndpoint: Endpoint {
    case independent
    case name(String)
    
    var path: String {
        switch self {
        case .independent:
            return "/independent"
        case .name(let query):
            return "/name/\(query)"
        }
    }
}
