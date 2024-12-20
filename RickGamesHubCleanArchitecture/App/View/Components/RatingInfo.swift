//
//  RatingInfo.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 21/12/24.
//

import SwiftUI

struct RatingInfo: View {
    let game: GameModel
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Text(String(format: "%.2f", game.rating))
                    .font(.headline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                ForEach(0..<Int(game.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                
                if game.rating - floor(game.rating) >= 0.5 {
                    Image(systemName: "star.lefthalf.fill")
                        .foregroundColor(.yellow)
                }
                
                ForEach(0..<5 - Int(game.rating.rounded(.down)) - (game.rating - floor(game.rating) >= 0.5 ? 1 : 0), id: \.self) { _ in
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
            }
            
            Spacer()
            
            Text("Released: \(game.released)")
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
    }
}

