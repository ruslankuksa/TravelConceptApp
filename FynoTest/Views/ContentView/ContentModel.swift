//
//  MainModel.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 19.06.2024.
//


import Observation

@Observable
final class ContentModel {
    
    private let userService: UserServiceProtocol
    private let countryService: CountryServiceProtocol
    private(set) var user: User
    private(set) var isLoading = false
    
    private(set) var countries: [Country] = []
    
    init(
        user: User = .defaultUser,
        userService: UserServiceProtocol = UserService(),
        countryService: CountryServiceProtocol = CountryService()
    ) {
        self.user = user
        self.userService = userService
        self.countryService = countryService
    }
    
    func fetchUserData() async {
        do {
            isLoading = true
            self.user = try await userService.getUser()
            isLoading = false
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchCountries() async {
        guard countries.isEmpty else { return }
        do {
            let countriesDTO = try await countryService.getAllCountries()
            self.countries = countriesDTO.map { $0.convertToCountry() }.sorted { $0.name < $1.name }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func addVisitedCountry(_ country: Country) {
        guard let containedCountry = user.countries.first(where: { $0.name == country.name }) else {
            addNewCountry(country, visited: true)
            return
        }
        
        if containedCountry.visited {
            removeCountry(country)
        } else {
            removeCountry(country)
            addNewCountry(country, visited: true)
        }
    }
    
    private func addNewCountry(_ country: Country, visited: Bool = false) {
        country.setVisited(visited)
        user.countries.insert(country, at: 0)
    }
    
    private func removeCountry(_ country: Country) {
        if let index = user.countries.firstIndex(where: { $0.name == country.name }) {
            user.countries.remove(at: index)
        }
    }
    
    func addUnvisitedCountry(_ country: Country) {
        if let containedCountry = user.countries.first(where: { $0.name == country.name }) {
            removeCountry(containedCountry)
            return
        }
        addNewCountry(country)
    }
    
    func getFilteredCountries(by query: String, exclude: [Country] = []) -> [Country] {
        guard !query.isEmpty else {
            return countries.filter { !exclude.contains($0) }
        }
        let filtered = countries.filter { !exclude.contains($0) }
        return filtered.filter { $0.name.contains(query) }
    }
}
