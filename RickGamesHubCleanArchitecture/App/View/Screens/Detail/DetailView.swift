//
//  DetailView.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailGameView: View {
    let game: GameModel
    @StateObject var detailViewModel: DetailViewModel = DetailViewModel(detailUseCase: AppInjection.init().provideDetailUseCase())
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var currentImageIndex: Int = 1
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                ImageSlider(game: game, currentIndex: $currentImageIndex)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(game.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        
                        RatingInfo(game: game)
                        
                        GameDescription(description: detailViewModel.gameDetail?.descriptionRaw ?? "Loading...")
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .onReceive(timer) { _ in
                withAnimation(.default) {
                    currentImageIndex = currentImageIndex == game.screenshots.count ? 1 : currentImageIndex + 1
                }
            }
            .onAppear {
                detailViewModel.fetchGameDetail(gameID: game.id)
                detailViewModel.checkFavorites(id: game.id)
            }
            .navigationBarTitle("Detail", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    FavoriteButton(isFavorite: $detailViewModel.isFavorites) {
                        toggleFavorite()
                    }
                }
            }
            .alert(isPresented: .constant(!detailViewModel.errorMessage.isEmpty)) {
                Alert(title: Text("Error"), message: Text(detailViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func toggleFavorite() {
        if detailViewModel.isFavorites {
            detailViewModel.removeFavorite(gameID: game.id)
            favoritesViewModel.getFavorites()
        } else {
            detailViewModel.addFavorite(game: game)
            favoritesViewModel.getFavorites()
        }
    }
}
