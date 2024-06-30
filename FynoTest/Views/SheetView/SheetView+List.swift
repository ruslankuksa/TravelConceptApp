//
//  SheetView+List.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 24.06.2024.
//

import SwiftUI

extension SheetView {
    
    var countriesList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20, pinnedViews: [.sectionHeaders]) {
                userProfileView
                
                statisticsView
                
                divider
                
                Section {
                    ForEach(visitedCountries) { country in
                        countryRow(country)
                    }
                    
                    Button(action: {
                        withAnimation {
                            visitedExtended.toggle()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.down")
                                .matchedGeometryEffect(id: "visitedExtendButton", in: animation)
                                .rotationEffect(.degrees(visitedExtended ? 180 : 0))
                            Text(extendedVisitedTitle)
                                .matchedGeometryEffect(id: "visitedExtendedTitle", in: animation)
                        }
                    })
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                } header: {
                    headerView(title: "I've been to:") {
                        addVisitedSheetPresented = true
                    }
                    .padding([.top, .horizontal])
                    .background()
                }
                
                divider
                
                Section {
                    ForEach(unvisitedCountries) { country in
                        countryRow(country)
                    }
                    
                    Button(action: {
                        withAnimation {
                            unvisitedExtended.toggle()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.down")
                                .matchedGeometryEffect(id: "unvisitedExtendButton", in: animation)
                                .rotationEffect(.degrees(unvisitedExtended ? 180 : 0))
                            Text(extendedUnvisitedTitle)
                                .matchedGeometryEffect(id: "unvisitedExtendedTitle", in: animation)
                        }
                    })
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                } header: {
                    headerView(title: "My bucket list:") {
                        addUnvisitedSheetPresented = true
                    }
                    .padding([.top, .horizontal])
                    .background()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func countryRow(_ country: Country) -> some View {
        HStack {
            Text(country.flag)
            Text(country.name)
        }
        .padding(.horizontal)
    }
}

extension SheetView {
    
    typealias Action = () -> Void
    
    func headerView(title: String, action: @escaping Action) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: action) {
                Label("Add country", systemImage: "plus")
            }
            .buttonStyle(CapsuleButtonStyle())
        }
    }
}
