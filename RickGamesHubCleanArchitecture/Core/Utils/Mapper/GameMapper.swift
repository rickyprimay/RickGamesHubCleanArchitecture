//
//  GameMapper.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct GameMapper {
    static func mapGameFavoritesToModels(response: [FavoritesGames]) -> [GameModel] {
        return response.map { result in
            return GameModel(
                id: Int(result.id),
                name: result.name ?? "",
                backgroundImageURL: URL(string: result.backgroundImage ?? ""),
                rating: result.rating,
                released: result.released ?? "",
                screenshots: (result.shortScreenshots?.allObjects as? [ShortScreenshots])?.compactMap { screenshot in
                    Screenshot(image: screenshot.image ?? "")
                } ?? []
            )
        }
    }
    
    static func mapGameResponseToModel(response: [Game]) -> [GameModel] {
        return response
            .map { result in
                GameModel(
                    id: Int(result.id),
                    name: result.name,
                    backgroundImageURL: URL(string: result.backgroundImage ?? ""),
                    rating: result.rating,
                    released: result.released,
                    screenshots: result.shortScreenshots
                )
            }
    }
}
