//
//  SearchGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct SearchGameRow: View {
    
    var game: FetchedResults<GameSearchCore>.Element
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name!)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(game.platforms!.joined(separator: ", "))
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                Text(game.developer!)
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            Spacer()
            // TODO: If game platform is in preferred then green Check else red Cross (X)
            VStack(alignment: .trailing, spacing: 4) {
                Text(String.init(format: "%.0f%%", game.rating))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(DateHelper.toString(game.releaseDate!))
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SearchGameRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SearchGameRow(game: GameSearchCore.example)
        }
    }
}
