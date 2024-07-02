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
        let visitedCountries = model.user.visitedCountries
        guard visitedCountries.count > 3 else {
            return visitedCountries
        }
        
        return Array(visitedCountries.prefix(visitedExtended ? visitedCountries.count : 3))
    }
    
    var unvisitedCountries: [Country] {
        let unvisitedCountries = model.user.unvisitedCountries
        guard unvisitedCountries.count > 3 else {
            return unvisitedCountries
        }
        return Array(unvisitedCountries.prefix(unvisitedExtended ? unvisitedCountries.count : 3))
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
