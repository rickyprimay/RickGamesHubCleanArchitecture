//
//  HomeUseCase.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Combine

protocol HomeUseCase {
    func fetchGames(page: Int, pageSize: Int) -> AnyPublisher<[GameModel], Error>
    func fetchGameSearch(query: String) -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepository
    
    required init(repository: GameRepository) {
        self.repository = repository
    }
    
    func fetchGames(page: Int, pageSize: Int) -> AnyPublisher<[GameModel], Error> {
        return repository.fetchGames(page: page, pageSize: pageSize)
    }
    
    func fetchGameSearch(query: String) -> AnyPublisher<[GameModel], Error> {
        return repository.fetchGameSearch(query: query)
    }
}
