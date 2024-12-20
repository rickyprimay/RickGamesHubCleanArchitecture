//
//  Untitled.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import SwiftUI


struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search game here...", text: $searchText)
                .padding(10)
                .background(.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.system(size: 16))
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.trailing, 10)
        }
        .padding(.horizontal, 10)
        .background(.gray)
        .cornerRadius(15)
    }
}

