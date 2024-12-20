//  GameCard.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCard: View {
    let game: GameModel
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: game.backgroundImageURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 340, height: 220)
                .clipped()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                                   startPoint: .bottom,
                                   endPoint: .top)
                    .cornerRadius(8)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(game.name)
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(maxWidth: 250, alignment: .leading)
                        .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 2)
                    
                    Spacer()
                }
                
                HStack {
                    Text(String(format: "%.1f", game.rating))
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                        .bold()
                    
                    ForEach(0..<Int(game.rating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    
                    if game.rating - floor(game.rating) >= 0.5 {
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    
                    Spacer()
                }
                
                Text("Release: \(game.released)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.6))
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
        )
        .frame(width: 340, height: 220)
        .cornerRadius(15)
    }
}
