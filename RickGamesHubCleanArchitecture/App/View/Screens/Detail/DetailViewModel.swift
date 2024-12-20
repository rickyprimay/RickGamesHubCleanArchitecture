//
//  DetailViewModel.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var favorites: [FavoritesGames] = []
    @Published var gameDetail: GameDetailModel? = nil
    @Published var isFavorites: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let detailUseCase: DetailUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func fetchGameDetail(gameID: Int) {
        isLoading = true
        detailUseCase.fetchGameDetails(gameID: gameID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { gameDetail in
                self.gameDetail = gameDetail
            })
            .store(in: &cancellables)
    }
    
    func checkFavorites(id: Int) {
        detailUseCase.isFavorite(gameID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: { isFavorite in
                self.isFavorites = isFavorite
            })
            .store(in: &cancellables)
    }
    
    func addFavorite(game: GameModel) {
        detailUseCase.addFavorite(game: game)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.isFavorites = true
                }
            }, receiveValue: { success in
                if success {
                    print("Successfully added to favorites.")
                }
            })
            .store(in: &cancellables)
    }
    
    func removeFavorite(gameID: Int) {
        detailUseCase.removeFavorite(gameID: gameID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.isFavorites = false
                    print("Game removed from favorites with ID: \(gameID)")
                }
            }, receiveValue: { success in
                if success {
                    print("Successfully removed from favorites.")
                }
            })
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .finished:
            break
        }
    }
}
