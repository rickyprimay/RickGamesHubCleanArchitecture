//
//  FavoriteButton.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 21/12/24.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Image(systemName: isFavorite ? "star.fill" : "star")
            .foregroundColor(.yellow)
            .onTapGesture {
                action()
            }
    }
}

