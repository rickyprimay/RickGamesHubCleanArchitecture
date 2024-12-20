//
//  GameDetail.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct GameDetail: Codable {
    let descriptionRaw: String
    
    enum CodingKeys: String, CodingKey {
        case descriptionRaw = "description_raw"
    }
}
