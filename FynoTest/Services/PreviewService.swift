//
//  PreviewService.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 23.06.2024.
//

import Foundation

struct PreviewService {
    
    private static let decoder = JSONDecoder()
    
    static func createPreviewUser() -> User {
        do {
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
                return User.defaultUser
            }
            let data = try Data(contentsOf: url)
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            return User.defaultUser
        }
    }
    
    static func createPreviewCountries() -> [Country] {
        let user = createPreviewUser()
        return user.countries
    }
}
