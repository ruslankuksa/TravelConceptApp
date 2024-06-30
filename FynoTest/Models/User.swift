//
//  User.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 19.06.2024.
//

import Foundation

struct User: Codable {
    
    var name, lastName: String
    var bio: String?
    var avatar: String?
    var countries: [Country] = []
    
    var avatarURL: URL? {
        guard let avatar else { return nil }
        return URL(string: avatar)
    }
    
    var fullName: String {
        return "\(name) \(lastName)"
    }
    
    var visitedCountries: [Country] {
        return countries.filter { $0.visited }
    }
    
    var unvisitedCountries: [Country] {
        return countries.filter { !$0.visited }
    }
    
    var visitedCountriesPercent: Float {
        guard visitedCountries.count < Country.totalCountries else {
            return 100
        }
        return (Float(visitedCountries.count) / Float(Country.totalCountries)) * 100
    }
}

extension User {
    
    static let defaultUser = User(
        name: "John",
        lastName: "Doe",
        bio: "Fearless hiker who likes to explore undiscovered places",
        avatar: "https://i.postimg.cc/tC8rSV5s/pascal-brauer-5k-Cx-Js-W4-Fs-unsplash.jpg"
    )
}
