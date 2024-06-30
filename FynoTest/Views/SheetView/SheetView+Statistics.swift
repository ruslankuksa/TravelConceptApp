//
//  SheetView+Statistics.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 23.06.2024.
//

import SwiftUI

extension SheetView {
    
    var statisticsView: some View {
        HStack {
            statisticsViewComponent(
                data: model.user.visitedCountries.count,
                label: "Countries"
            )
            
            Capsule()
                .frame(width: 1.5, height: 30)
                .foregroundStyle(Color(UIColor.systemGray5))
            
            statisticsViewComponent(
                data: "\(String(format: "%.2f", model.user.visitedCountriesPercent))%",
                label: "World"
            )
        }
    }
    
    private func statisticsViewComponent<T: CustomStringConvertible>(data: T, label: String) -> some View {
        VStack {
            Text(data.description)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}
