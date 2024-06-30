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
//    @State private var mapPosition: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    
    var body: some View {
        Map {
            ForEach(model.user.countries) { country in
                Annotation(country.name, coordinate: country.locationCoordinate) {
                    BubbleAnnotationView(image: country.flag, showBadge: country.visited)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .task {
            await model.fetchUserData()
        }
        .overlay {
            if model.isLoading {
                ProgressView()
                    .tint(.white)
            }
        }
        .sheet(isPresented: $sheetPresented) {
            GeometryReader { proxy in
                SheetView(model: model)
                    .interactiveDismissDisabled()
                    .presentationDetents([.fraction(0.2), .medium, .fraction(0.7)], selection: $presentationDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .presentationContentInteraction(.resizes)
                    .presentationCornerRadius(25)
                    .presentationDragIndicator(.hidden)
                    .clipShape(
                        .rect(topLeadingRadius: 16, topTrailingRadius: 16)
                    )
                    .onChange(of: presentationDetent) {
                        if presentationDetent == .fraction(0.2) {
                            presentationDetent = .medium
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
