//
//  Country.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 23.06.2024.
//

import Foundation
import CoreLocation

final class Country: Codable, Identifiable {
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    static let totalCountries = 194
    
    var id: String {
        return name
    }
    
    let name: String
    let flag: String
    let location: Location
    var visited: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
    
    init(name: String, flag: String, location: Location, visited: Bool = false) {
        self.name = name
        self.flag = flag
        self.location = location
        self.visited = visited
    }
    
    func setVisited(_ value: Bool) {
        self.visited = value
    }
}

extension Country: CustomStringConvertible {
    
    var description: String {
        return "\(flag) \(name)"
    }
}

extension Country: Equatable, Hashable {
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
