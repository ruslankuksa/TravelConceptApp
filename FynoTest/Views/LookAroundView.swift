//
//  LookAroundView.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 04.07.2024.
//

import SwiftUI
import MapKit

struct LookAroundView: View {
    
    @State private var lookAroundScene: MKLookAroundScene?
    
    var body: some View {
        LookAroundPreview(scene: $lookAroundScene)
            .onAppear {
                Task {
                    await prepeareScene()
                }
            }
    }
    
    private func prepeareScene() async {
        lookAroundScene = nil
        let request = MKLookAroundSceneRequest(coordinate: CLLocationCoordinate2D(latitude: 52.51948069659376, longitude: 13.40314134415408))
        do {
            let newScene = try await request.scene
            debugPrint("New scene is \(newScene)")
            lookAroundScene = newScene
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

#Preview {
    LookAroundView()
}
