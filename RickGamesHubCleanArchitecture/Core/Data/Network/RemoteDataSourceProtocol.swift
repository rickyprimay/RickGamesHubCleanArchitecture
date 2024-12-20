//  RemoteDataSource.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func fetchGames(page: Int, pageSize: Int, completion: @escaping (Result<[GameModel], Error>) -> Void)
    func fetchGameDetails(gameID: Int, completion: @escaping (Result<GameDetailModel, Error>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let instance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func fetchGames(page: Int, pageSize: Int, completion: @escaping (Result<[GameModel], Error>) -> Void) {
        let url = NetworkConstants.baseUrl + "games"
        let parameters: [String: Any] = [
            "page": page,
            "page_size": pageSize,
            "key": NetworkConstants.apiKey
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: GameResult.self) { response in
                switch response.result {
                case .success(let gamesResponse):
                    let gameModels = GameMapper.mapGameResponseToModel(response: gamesResponse.results)
                    completion(.success(gameModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchGameDetails(gameID: Int, completion: @escaping (Result<GameDetailModel, Error>) -> Void) {
        let url = NetworkConstants.baseUrl + "games/\(gameID)"
        let parameters: [String: Any] = [
            "key": NetworkConstants.apiKey
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: GameDetail.self) { response in
                switch response.result {
                case .success(let gameDetail):
                    let gameDetailModel = GameDetailMapper.map(dto: gameDetail)
                    completion(.success(gameDetailModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
