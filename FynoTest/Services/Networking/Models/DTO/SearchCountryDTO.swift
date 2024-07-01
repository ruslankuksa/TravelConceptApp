//
//  CountryDTO.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 28.06.2024.
//

import Foundation

struct SearchCountryDTO: Decodable, Identifiable, CustomStringConvertible {
    
    struct Name: Decodable {
        let common: String
        let official: String
    }
    
    var id: String {
        return name.official
    }
    
    let name: Name
    let flag: String
    let latlng: [Double]
    
    var description: String {
        return "\(flag) \(name.common)"
    }
    
    var latitude: Double {
        return latlng.first ?? 0
    }
    
    var longitude: Double {
        return latlng.last ?? 0
    }
    
    func convertToCountry() -> Country {
        return Country(
            name: name.common,
            flag: flag,
            location: Country.Location(
                latitude: latitude,
                longitude: longitude
            )
        )
    }
}
