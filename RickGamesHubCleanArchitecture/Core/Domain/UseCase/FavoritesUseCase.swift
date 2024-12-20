//
//  FavoritesUseCase.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Combine

protocol FavoritesUseCase {
    func fetchFavorites() -> AnyPublisher<[GameModel], Error>
}

class FavoritesInteractor: FavoritesUseCase {
    private let repository: GameRepository
    
    required init(repository: GameRepository) {
        self.repository = repository
    }
    
    func fetchFavorites() -> AnyPublisher<[GameModel], Error> {
        return repository.getFavorites()
    }
}
