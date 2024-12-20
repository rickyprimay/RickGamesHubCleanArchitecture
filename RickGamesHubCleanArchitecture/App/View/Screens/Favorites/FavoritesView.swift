//  FavoritesView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @StateObject private var vm: FavoritesViewModel = FavoritesViewModel(favoritesUseCase: AppInjection.init().provideFavoritesUseCase())
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                if !vm.favorites.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(vm.favorites, id: \.id) { game in
                                NavigationLink {
                                    let screenshots = game.screenshots.map { screenshot in
                                        Screenshot(image: screenshot.image)
                                    }
                                    
                                    DetailGameView(game: game)
                                } label: {
                                    ResultSearch(game: game)
                                }
                            }
                        }
                        .padding(.top)
                        .navigationTitle("Favorite Games")
                    }
                } else {
                    Text("No favorite games yet")
                        .font(.title)
                        .foregroundStyle(.gray)
                        .navigationTitle("Favorite Games")
                }
            }
        }
        .onAppear {
            vm.getFavorites()
        }
    }
}
