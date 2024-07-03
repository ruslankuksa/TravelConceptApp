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
                            .matchedGeometryEffect(id: "\(country.name)_visited", in: animation)
                    }
                    
                    if model.user.visitedCountries.count > 3 {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    }
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
                            .matchedGeometryEffect(id: "\(country.name)_unvisited", in: animation)
                    }
                    
                    if model.user.unvisitedCountries.count > 3 {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    }
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
        Button {
            model.selectCountry(country)
        } label: {
            HStack {
                Text(country.flag)
                Text(country.name)
            }
            .padding(.horizontal)
            .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
    }
}

extension SheetView {
    
    private func headerView(title: String, action: @escaping Action) -> some View {
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
