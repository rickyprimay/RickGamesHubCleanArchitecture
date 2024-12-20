//
//  Screenshot.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct Screenshot: Codable {
    let image: String
    
    var screenShotURL: URL? {
        return URL(string: image)
    }
}
