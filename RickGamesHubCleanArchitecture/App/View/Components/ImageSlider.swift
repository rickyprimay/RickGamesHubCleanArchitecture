//
//  ImageSlider.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 21/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageSlider: View {
    let game: GameModel
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            TabView(selection: $currentIndex) {
                ForEach(game.screenshots.indices, id: \.self) { index in
                    WebImage(url: game.screenshots[index].screenShotURL)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .cornerRadius(20)
                        .tag(index + 1)
                        .clipped()
                }
            }
            .frame(height: 200)
            .cornerRadius(20)
            .tabViewStyle(PageTabViewStyle())
            .padding()
        }
        .frame(height: 200)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
