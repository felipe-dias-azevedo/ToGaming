//
//  RecentlySearchedGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 05/04/22.
//

import SwiftUI

struct RecentlySearchedGameRow: View {
    
    var game: GameSearch
    
    var body: some View {
        HStack {
            Image(game.coverImageName)
                .resizable()
                .frame(width: 56.25, height: 75)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(game.platforms.joined(separator: ", "))
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                Text(game.developer)
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            Spacer()
            // TODO: If game platform is in preferred then green Check else red Cross (X)
            VStack(alignment: .trailing, spacing: 4) {
                Text(String.init(format: "%.0f%%", game.rating))
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                Text(DateHelper.toString(game.releaseDate))
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct RecentlySearchedGameRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecentlySearchedGameRow(game: ModelData().recentlySearched[0])
            RecentlySearchedGameRow(game: ModelData().recentlySearched[1])
            RecentlySearchedGameRow(game: ModelData().recentlySearched[2])
        }
    }
}
