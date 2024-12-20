//
//  GameModel.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct GameModel: Identifiable {
    let id: Int
    let name: String
    let backgroundImageURL: URL?
    let rating: Double
    let released: String
    let screenshots: [Screenshot]
}
