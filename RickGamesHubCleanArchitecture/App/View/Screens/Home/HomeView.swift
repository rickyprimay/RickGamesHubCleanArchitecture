//
//  HomeView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel = HomeViewModel(homeUseCase: AppInjection.init().provideHomeUseCase())
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal)
                        .onChange(of: searchText) {
                            if searchText.count > 2 {
                                vm.fetchGameSearch(query: searchText)
                            }
                        }
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            if searchText.isEmpty {
                                if vm.games.isEmpty {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .padding(.top)
                                    Text("Loading...")
                                } else {
                                    VStack(alignment: .leading) {
                                        Text("Best Game Ever")
                                            .font(.title)
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(vm.games) { game in
                                                    NavigationLink {
                                                        DetailGameView(game: game)
                                                    } label: {
                                                        GameCardView(game: game)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Recommended For You")
                                            .font(.title)
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(vm.randomGames) { game in
                                                    NavigationLink {
                                                        DetailGameView(game: game)
                                                    } label: {
                                                        GameCardView(game: game)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            } else {
                                if vm.filteredGames.isEmpty {
                                    Text("No Results Found")
                                        .foregroundColor(.gray)
                                        .font(.title3)
                                        .padding()
                                } else {
                                    LazyVStack {
                                        ForEach(vm.filteredGames) { game in
                                            NavigationLink {
                                                DetailGameView(game: game)
                                            } label: {
                                                ResultSearchView(game: game)
                                            }
                                        }
                                    }
                                    .padding(.top)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("RickGamesHub", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "gamecontroller")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
