//
//  Netwok.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import Foundation

struct Network {
    static let baseUrl = "https://api.rawg.io/api/"
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }
}
