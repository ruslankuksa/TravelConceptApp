//
//  SheetView+UserProfile.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 23.06.2024.
//

import SwiftUI

extension SheetView {
    
    var userProfileView: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: model.user.avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
//                    .background(
//                        Circle()
//                            .foregroundStyle(.white)
//                            .frame(width: 70, height: 70)
//                    )
            } placeholder: {
                Image(systemName: "person.crop.circle")
                    .foregroundStyle(.indigo)
                    .font(.system(size: 50))
            }
//            .offset(y: -20)
            
            VStack(alignment: .leading) {
                Text(model.user.fullName)
                    .fontWeight(.semibold)
                Text(model.user.bio ?? "")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.top, .horizontal])
    }
}
