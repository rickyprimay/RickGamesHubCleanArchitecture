//
//  GamesRepositoryImpl.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Combine

class GameRepositoryImpl {
    
    typealias GameRepositoryInstance = (LocalDataSource, RemoteDataSource) -> GameRepositoryImpl
    
    fileprivate let local: LocalDataSource
    fileprivate let remote: RemoteDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let instance: GameRepositoryInstance = { localSource, remoteSource in
        return GameRepositoryImpl(local: localSource, remote: remoteSource)
    }
}

extension GameRepositoryImpl: GameRepository {
    func fetchGameSearch(query: String) -> AnyPublisher<[GameModel], any Error> {
        return Future { promise in
            self.remote.fetchGameSearch(query: query) { result in
                switch result {
                case .success(let games):
                    promise(.success(games))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchGames(page: Int, pageSize: Int) -> AnyPublisher<[GameModel], Error> {
        return Future { promise in
            self.remote.fetchGames(page: page, pageSize: pageSize) { result in
                switch result {
                case .success(let games):
                    promise(.success(games))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchGameDetails(gameID: Int) -> AnyPublisher<GameDetailModel, Error> {
        return Future { promise in
            self.remote.fetchGameDetails(gameID: gameID) { result in
                switch result {
                case .success(let gameDetail):
                    promise(.success(gameDetail))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            self.local.addFavorite(game: game) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func removeFavorite(gameID: Int) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            self.local.removeFavorite(gameID: gameID) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func isFavorite(gameID: Int) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            self.local.isFavorite(gameID: gameID) { result in
                switch result {
                case .success(let isFavorite):
                    promise(.success(isFavorite))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[GameModel], Error> {
        return Future { promise in
            self.local.getFavorites { result in
                switch result {
                case .success(let favorites):
                    promise(.success(favorites))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
