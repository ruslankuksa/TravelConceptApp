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
            self.countries = countriesDTO.map { $0.convertToCountry() }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func addVisitedCountry(_ country: Country) {
        var visitedCountry = country
        visitedCountry.setVisited(true)
        user.countries.insert(visitedCountry, at: 0)
    }
    
    func getFilteredCountries(by query: String) -> [Country] {
        guard !query.isEmpty else {
            return countries
        }
        return countries.filter { $0.name.contains(query) }
    }
    
    func addUnvisitedCountry(_ country: Country) {
        user.countries.insert(country, at: 0)
    }
}
