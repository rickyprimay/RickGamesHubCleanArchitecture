//
//  FavoritesViewModel.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [GameModel] = []
    
    let favoritesUseCase: FavoritesUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(favoritesUseCase: FavoritesUseCase) {
        self.favoritesUseCase = favoritesUseCase
    }
    
    func getFavorites() {
        favoritesUseCase.fetchFavorites()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { favorites in
                self.favorites = favorites
            }
            .store(in: &cancellable)
    }
}
