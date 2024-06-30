//
//  CapsuleButtonStyle.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 20.06.2024.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .foregroundStyle(Color.indigo)
            .background(Color(UIColor.systemGray6))
            .font(.body)
            .fontWeight(.semibold)
            .clipShape(Capsule())
            .dynamicTypeSize(.large)
    }
}

#Preview {
    Button {
        
    } label: {
        Label("Add country", systemImage: "plus")
    }
    .buttonStyle(CapsuleButtonStyle())
}

