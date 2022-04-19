//
//  RecentlySearchedGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 05/04/22.
//

import SwiftUI

struct RecentlySearchedGameRow: View {
    
    var game: FetchedResults<GameSearchCore>.Element
    
    var body: some View {
        HStack {
            RemoteImage(url: ImageHelper.toURL(game.coverImageName!), type: .recentRow)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name!)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(game.platforms!.joined(separator: ", "))
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Text(game.developer!)
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            // TODO: If game platform is in preferred then green Check else red Cross (X)
            VStack(alignment: .trailing, spacing: 4) {
                Text(String.init(format: "%.0f%%", game.rating))
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                Text(DateHelper.toString(game.releaseDate!))
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct RecentlySearchedGameRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecentlySearchedGameRow(game: GameSearchCore.example)
        }
    }
}
