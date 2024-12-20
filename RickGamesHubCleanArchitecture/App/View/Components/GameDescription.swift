//
//  GameDescription.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 21/12/24.
//

import SwiftUI

struct GameDescription: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Game Description")
                .font(.headline)
                .padding(.horizontal)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
