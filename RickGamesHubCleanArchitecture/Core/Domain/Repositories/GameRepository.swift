//
//  GameRepository.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Combine

protocol GameRepository {
    func fetchGames(page: Int, pageSize: Int) -> AnyPublisher<[GameModel], Error>
    func fetchGameDetails(gameID: Int) -> AnyPublisher<GameDetailModel, Error>
    
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(gameID: Int) -> AnyPublisher<Bool, Error>
    func isFavorite(gameID: Int) -> AnyPublisher<Bool, Error>
    func getFavorites() -> AnyPublisher<[GameModel], Error>
}
