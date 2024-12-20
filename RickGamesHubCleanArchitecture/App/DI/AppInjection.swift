//
//  AppInjection.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

final class AppInjection: NSObject {
    private let coreInjection: CoreInjection
    
    init(coreInjection: CoreInjection = CoreInjection()) {
        self.coreInjection = coreInjection
    }
    
    private lazy var gameRepository: GameRepository = {
        coreInjection.provideGameRepository()
    }()
    
    func provideHomeUseCase() -> HomeUseCase {
        return HomeInteractor(repository: gameRepository)
    }
    
    func provideDetailUseCase() -> DetailUseCase {
        return DetailInteractor(repository: gameRepository)
    }
    
    func provideFavoritesUseCase() -> FavoritesUseCase {
        return FavoritesInteractor(repository: gameRepository)
    }
}
