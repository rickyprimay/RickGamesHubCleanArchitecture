//
//  DetailUseCase.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Combine

protocol DetailUseCase {
    func fetchGameDetails(gameID: Int) -> AnyPublisher<GameDetailModel, Error>
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(gameID: Int) -> AnyPublisher<Bool, Error>
    func isFavorite(gameID: Int) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: GameRepository
    
    required init(repository: GameRepository) {
        self.repository = repository
    }
    
    func fetchGameDetails(gameID: Int) -> AnyPublisher<GameDetailModel, any Error> {
        return repository.fetchGameDetails(gameID: gameID)
    }
    
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(game: game)
    }
    
    func removeFavorite(gameID: Int) -> AnyPublisher<Bool, Error> {
        return repository.removeFavorite(gameID: gameID)
    }
    
    func isFavorite(gameID: Int) -> AnyPublisher<Bool, Error> {
        return repository.isFavorite(gameID: gameID)
    }
}
