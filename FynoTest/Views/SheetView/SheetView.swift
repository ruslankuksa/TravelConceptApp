//
//  SheetView.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 19.06.2024.
//

import SwiftUI

struct SheetView: View {
    
    @Bindable var model: ContentModel
    
    @State var addVisitedSheetPresented = false
    @State var addUnvisitedSheetPresented = false
    
    @State var visitedExtended = false
    @State var unvisitedExtended = false
    @State private var query = ""
    @Namespace var animation
    
    private let prefix = 3
    
    var visitedCountries: [Country] {
        let visited = model.user.visitedCountries
        return Array(visited.prefix(visitedExtended ? visited.count : 3))
    }
    
    var unvisitedCountries: [Country] {
        let unvisited = model.user.unvisitedCountries
        return Array(unvisited.prefix(unvisitedExtended ? unvisited.count : 3))
    }
    
    var extendedVisitedTitle: String {
        if visitedExtended {
            return "See less"
        } else {
            return "See \(model.user.visitedCountries.count - prefix) more"
        }
    }
    
    var extendedUnvisitedTitle: String {
        if unvisitedExtended {
            return "See less"
        } else {
            return "See \(model.user.unvisitedCountries.count - prefix) more"
        }
    }
    
    var body: some View {
        countriesList
            .background()
            .sheet(isPresented: $addVisitedSheetPresented) {
                SearchView(query: $query, data: model.getFilteredCountries(by: query)) { country in
                    HStack {
                        Text(country.description)
                        if model.user.visitedCountries.contains(country) {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                        }
                    }
                } onSelect: { country in
                    model.addVisitedCountry(country)
                }
                .task {
                    await model.fetchCountries()
                }
            }
            .sheet(isPresented: $addUnvisitedSheetPresented) {
                SearchView(
                    query: $query,
                    data: model.getFilteredCountries(by: query, exclude: model.user.visitedCountries)
                ) { country in
                    HStack {
                        Text(country.description)
                        if model.user.unvisitedCountries.contains(country) {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                        }
                    }
                } onSelect: { country in
                    model.addUnvisitedCountry(country)
                }
                .task {
                    await model.fetchCountries()
                }
            }
    }
    
    var divider: some View {
        Capsule()
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .foregroundStyle(Color(UIColor.systemGray5))
    }
}

#Preview {
    SheetView(model: ContentModel(user: PreviewService.createPreviewUser()))
}
