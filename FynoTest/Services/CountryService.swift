//
//  CountryService.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 28.06.2024.
//

import Foundation
import NetRunner

protocol CountryServiceProtocol {
    
    func getAllCountries() async throws -> [SearchCountryDTO]
}

final class CountryService: CountryServiceProtocol, NetRunner {
    
    func getAllCountries() async throws -> [SearchCountryDTO] {
        let request = CountryRequest(endpoint: .independent)
        return try await execute(request: request)
    }
}
