//  HomeViewModel.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let homeUseCase: HomeUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var games: [GameModel] = []
    @Published var randomGames: [GameModel] = []
    @Published var filteredGames: [GameModel] = []
    
    @Published var isLoadingRecommended: Bool = false
    @Published var isLoadingPopular: Bool = false
    
    @Published var errorMessage: String = ""
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        fetchGames()
        fetchRandomGames()
    }
    
    func fetchGames() {
        isLoadingRecommended = true
        homeUseCase.fetchGames(page: 1, pageSize: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion(isRecommended: true), receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func fetchRandomGames() {
        isLoadingPopular = true
        homeUseCase.fetchGames(page: 1, pageSize: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion(isRecommended: false), receiveValue: { games in
                self.randomGames = games.shuffled() 
            })
            .store(in: &cancellables)
    }
    
    func fetchGameSearch(query: String) {
        homeUseCase.fetchGameSearch(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { games in
                self.filteredGames = games
            })
            .store(in: &cancellables)
    }
    
    private func handleCompletion(isRecommended: Bool) -> (Subscribers.Completion<Error>) -> Void {
        return { completion in
            switch completion {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .finished:
                if isRecommended {
                    self.isLoadingRecommended = false
                } else {
                    self.isLoadingPopular = false
                }
            }
        }
    }
}
