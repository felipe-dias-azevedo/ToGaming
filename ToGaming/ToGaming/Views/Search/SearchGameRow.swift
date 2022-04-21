//
//  SearchGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct SearchGameRow: View {
    
    var game: GameNewSearch
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(game.platforms.joined(separator: ", "))
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                if let developer = game.developer {
                    Text(developer)
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            Spacer()
            // TODO: If game platform is in preferred then green Check else red Cross (X)
            VStack(alignment: .trailing, spacing: 4) {
                if let rating = game.rating {
                    Text(String.init(format: "%.0f%%", rating))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
                if let releaseDate = game.releaseDate {
                    Text(DateHelper.toString(releaseDate))
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct SearchGameRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SearchGameRow(game: GameNewSearch(id: 1, name: "Game 1", rating: 10.0, releaseDate: Date(), platforms: ["Playstation 4", "Xbox One", "PC"], developer: "Developer 1"))
        }
    }
}
