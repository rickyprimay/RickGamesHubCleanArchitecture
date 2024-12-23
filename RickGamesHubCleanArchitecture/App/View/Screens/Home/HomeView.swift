import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel(homeUseCase: AppInjection.init().provideHomeUseCase())
    @State var searchText: String = ""
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal)
                        .onChange(of: searchText) {
                            if searchText.count > 2 {
                                homeViewModel.fetchGameSearch(query: searchText)
                            }
                        }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            if searchText.isEmpty {
                                if homeViewModel.games.isEmpty {
                                    VStack {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .padding()
                                        Text("Loading...")
                                            .foregroundColor(.gray)
                                    }
                                } else {
                                    SectionView(
                                        title: "Best Game Ever",
                                        games: homeViewModel.games
                                    )
                                    .environmentObject(favoritesViewModel)
                                    
                                    SectionView(
                                        title: "Recommended For You",
                                        games: homeViewModel.randomGames
                                    )
                                    .environmentObject(favoritesViewModel)
                                }
                            } else {
                                if homeViewModel.filteredGames.isEmpty {
                                    VStack {
                                        Image(systemName: "magnifyingglass")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                        Text("No Results Found")
                                            .foregroundColor(.gray)
                                            .font(.title3)
                                    }
                                    .padding()
                                } else {
                                    LazyVStack {
                                        ForEach(homeViewModel.filteredGames) { game in
                                            NavigationLink {
                                                DetailGameView(game: game)
                                                    .environmentObject(favoritesViewModel)
                                            } label: {
                                                ResultSearch(game: game)
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
