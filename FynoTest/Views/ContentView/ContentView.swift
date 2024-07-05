//
//  ContentView.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 18.06.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var model = ContentModel()
    
    @State private var sheetPresented = true
    @State private var presentationDetent: PresentationDetent = .medium
    @State private var mapPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: .init(), distance: Double.infinity))
    @State private var mapOffset: CGFloat = 0
    @State private var onMapSelected: MapFeature?
    
    var body: some View {
        Map(position: $mapPosition, selection: $onMapSelected) {
            ForEach(model.user.countries) { country in
                Annotation(country.name, coordinate: country.locationCoordinate) {
                    Button {
                        withAnimation {
                            model.selectCountry(country)
                        }
                    } label: {
                        BubbleAnnotationView(image: country.flag, showBadge: country.visited)
                    }
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .offset(y: -mapOffset + mapOffset / 2)
        .contentMargins(.vertical, mapOffset / 2, for: .scrollContent)
        .task {
            await model.fetchUserData()
        }
        .overlay {
            if model.isLoading {
                ProgressView()
                    .tint(.white)
            }
        }
        .onChange (of: model.selectedCountry) {
            if let country = model.selectedCountry {
                withAnimation {
                    moveMapCamera(on: country)
                }
            }
        }
        .onChange(of: onMapSelected) { oldValue, newValue in
            debugPrint(newValue?.title ?? "No selection value")
        }
        .sheet(isPresented: $sheetPresented) {
            GeometryReader { proxy in
                SheetView(model: model)
                    .interactiveDismissDisabled()
                    .presentationDetents([.fraction(0.2), .medium, .fraction(0.7)], selection: $presentationDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.7)))
                    .presentationContentInteraction(.resizes)
                    .presentationCornerRadius(25)
                    .presentationDragIndicator(.hidden)
                    .onChange(of: presentationDetent) {
                        if presentationDetent == .fraction(0.2) {
                            presentationDetent = .medium
                        }
                    }
                    .onChange(of: proxy.size) {
                        withAnimation {
                            mapOffset = proxy.size.height
                        }
                    }
            }
        }
    }
    
    private func moveMapCamera(on country: Country) {
        let distanceOnSelect: Double = 3000000
        mapPosition = .camera(
            MapCamera(
                centerCoordinate: country.locationCoordinate,
                distance: distanceOnSelect
            )
        )
    }
}

#Preview {
    ContentView()
}
