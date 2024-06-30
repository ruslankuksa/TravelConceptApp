//
//  UserService.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 21.06.2024.
//

import Foundation

protocol UserServiceProtocol {
    
    func getUser() async throws -> User
}

final class UserService: UserServiceProtocol {
    
    enum Error: LocalizedError {
        case invalidURL
    }
    
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    func getUser() async throws -> User {
        try await Task.sleep(nanoseconds: 1000000000)
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            throw Error.invalidURL
        }
        let data = try Data(contentsOf: url)
        let user = try decoder.decode(User.self, from: data)
        return user
    }
}
