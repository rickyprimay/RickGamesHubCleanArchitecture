//
//  GameDetailMapper.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct GameDetailMapper {
    static func map(dto: GameDetail) -> GameDetailModel {
        return GameDetailModel(descriptionRaw: dto.descriptionRaw)
    }
}
