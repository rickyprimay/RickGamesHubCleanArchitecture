//
//  SectionView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI

struct SectionView: View {
    let title: String
    let games: [GameModel]
    @State private var animateCards: Bool = false
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(games.indices, id: \.self) { index in
                        NavigationLink {
                            DetailGameView(game: games[index])
                                .environmentObject(favoritesViewModel)
                        } label: {
                            GameCard(game: games[index])
                                .frame(width: 300)
                                .scaleEffect(animateCards ? 1 : 0.9)
                                .opacity(animateCards ? 1 : 0)
                                .onAppear {
                                    withAnimation(
                                        .easeOut(duration: 0.5)
                                        .delay(Double(index) * 0.1)
                                    ) {
                                        animateCards = true
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(10)
    }
}
