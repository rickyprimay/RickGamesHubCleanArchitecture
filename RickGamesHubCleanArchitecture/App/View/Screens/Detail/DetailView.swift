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
    @StateObject var vm: DetailViewModel = DetailViewModel(detailUseCase: AppInjection.init().provideDetailUseCase())
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var currentImageIndex: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                Color.gray.opacity(0.2)
                TabView(selection: $currentImageIndex) {
                    ForEach(game.screenshots.indices, id: \.self) { index in
                        WebImage(url: game.screenshots[index].screenShotURL)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .tag(index + 1)
                            .clipped()
                    }
                }
                .frame(height: 200)
                .cornerRadius(10)
                .tabViewStyle(PageTabViewStyle())
                .padding()
            }
            .frame(height: 200)
            .cornerRadius(10)
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(game.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    HStack {
                        HStack(spacing: 2) {
                            Text(String(format: "%.2f", game.rating))
                                .font(.headline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            ForEach(0..<Int(game.rating), id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                            if game.rating - floor(game.rating) >= 0.5 {
                                Image(systemName: "star.lefthalf.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                            ForEach(0..<5 - Int(game.rating.rounded(.down)) - (game.rating - floor(game.rating) >= 0.5 ? 1 : 0), id: \.self) { _ in
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        Spacer()
                        
                        Text("Released: \(game.released)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    Text("Game Description")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(vm.gameDetail?.descriptionRaw ?? "Loading...")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .lineSpacing(5)
                    
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                currentImageIndex = currentImageIndex == game.screenshots.count ? 1 : currentImageIndex + 1
            }
        }
        .onAppear {
            vm.fetchGameDetail(gameID: game.id)
            vm.checkFavorites(id: game.id)
        }
        .navigationBarTitle("Detail", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: vm.isFavorites ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        toggleFavorite()
                    }
            }
        }
        .alert(isPresented: .constant(!vm.errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func toggleFavorite() {
        if vm.isFavorites {
            if let gameDetail = vm.gameDetail {
                vm.removeFavorite(gameID: game.id)
            }
        } else {
            vm.addFavorite(game: game)
        }
    }
}
