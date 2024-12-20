//
//  Game.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let backgroundImage: String?
    let rating: Double
    let released: String
    let shortScreenshots: [Screenshot]
    
    var backgroundImageURL: URL? {
        URL(string: backgroundImage ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating, released
        case backgroundImage = "background_image"
        case shortScreenshots = "short_screenshots"
    }
}
