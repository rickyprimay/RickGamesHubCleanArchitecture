//
//  RootView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Favorites")
                .tabItem{
                    Image(systemName: "star")
                    Text("Favorites")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    RootView()
}
