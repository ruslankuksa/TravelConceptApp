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
    
    var body: some View {
        Map(position: $mapPosition) {
            ForEach(model.user.countries) { country in
                Annotation(country.name, coordinate: country.locationCoordinate) {
                    BubbleAnnotationView(image: country.flag, showBadge: country.visited)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .offset(y: -mapOffset + mapOffset / 2)
        .contentMargins(.bottom, mapOffset / 2, for: .automatic)
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
}

#Preview {
    ContentView()
}
