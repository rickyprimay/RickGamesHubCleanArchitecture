//
//  HomeView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    @State var searchText: String = ""
    
    init() {
        let appInjection = AppInjection(coreInjection: CoreInjection())
        _vm = StateObject(wrappedValue: HomeViewModel(homeUseCase: appInjection.provideHomeUseCase()))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal)
                        .onChange(of: searchText) {
                            
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
                                                        Text("detail")
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
                                                        Text("Detail")
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
                                                Text("detail")
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
