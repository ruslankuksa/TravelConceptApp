//
//  BubbleAnnotationView.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 20.06.2024.
//

import SwiftUI

struct BubbleAnnotationView: View {
    
    let image: String
    var showBadge: Bool = false
    
    var body: some View {
        ZStack {
            Image(systemName: "bubble.middle.bottom.fill")
                .foregroundStyle(Color(UIColor.systemGray6))
                .font(.system(size: 40))
            
            Text(image)
                .offset(y: -3.5)
                .font(.system(size: 25))
            
            if showBadge {
                Image(systemName: "checkmark.circle.fill")
                    .background(Color.white)
                    .clipShape(Circle())
                    .foregroundStyle(.indigo)
                    .offset(x: 17, y: -18)
            }
        }
    }
}

#Preview {
    BubbleAnnotationView(image: "🇩🇪", showBadge: true)
}
