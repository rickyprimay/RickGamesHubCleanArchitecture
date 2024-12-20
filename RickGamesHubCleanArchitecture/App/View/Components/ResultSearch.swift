//  ResultSearch.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ResultSearch: View {
    
    var game: GameModel
    
    var body: some View {
        HStack(spacing: 16) {
            WebImage(url: game.backgroundImageURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 6)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(game.name)
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text(String(format: "%.1f", game.rating))
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            if index < Int(game.rating) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else if index < Int(game.rating.rounded()) {
                                Image(systemName: "star.lefthalf.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                
                Text("Released: \(game.released)")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.footnote)
            }
            .padding(.vertical, 8)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
        )
        .padding(.horizontal)
        .frame(height: 180)
    }
}
