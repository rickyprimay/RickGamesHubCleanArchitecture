//
//  RootView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var favoritesViewModel: FavoritesViewModel = FavoritesViewModel(favoritesUseCase: AppInjection.init().provideFavoritesUseCase())
    
    var body: some View {
        TabView {
            HomeView()
            
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
                .toolbarBackground(
                    Color.blue.opacity(0.2),
                    for: .tabBar)
            FavoritesView()
                .environmentObject(favoritesViewModel)
                .tabItem{
                    Image(systemName: "star")
                    Text("Favorites")
                }
                .toolbarBackground(
                    Color.blue.opacity(0.2),
                    for: .tabBar)
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }
                .toolbarBackground(
                    Color.blue.opacity(0.2),
                    for: .tabBar)
        }
    }
}

#Preview {
    RootView()
}
