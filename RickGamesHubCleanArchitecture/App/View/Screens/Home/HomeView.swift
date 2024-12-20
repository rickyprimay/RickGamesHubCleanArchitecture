import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel = HomeViewModel(homeUseCase: AppInjection.init().provideHomeUseCase())
    @State var searchText: String = ""
    
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
                                vm.fetchGameSearch(query: searchText)
                            }
                        }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            if searchText.isEmpty {
                                if vm.games.isEmpty {
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
                                        games: vm.games
                                    )
                                    
                                    SectionView(
                                        title: "Recommended For You",
                                        games: vm.randomGames
                                    )
                                }
                            } else {
                                if vm.filteredGames.isEmpty {
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
                                        ForEach(vm.filteredGames) { game in
                                            NavigationLink {
                                                DetailGameView(game: game)
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
