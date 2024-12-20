//
//  CoreInjection.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

final class CoreInjection: NSObject {
    func provideGameRepository() -> GameRepository {
        let localData = LocalDataSource.instance
        let remoteData = RemoteDataSource.instance
        
        return GameRepositoryImpl.instance(localData, remoteData)
    }
}
