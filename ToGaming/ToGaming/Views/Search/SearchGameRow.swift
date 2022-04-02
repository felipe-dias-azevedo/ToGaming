//
//  SearchGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct SearchGameRow: View {
    
    var game: GameSearch
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(game.developer)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            Spacer()
            // TODO: If game platform is in preferred then green Check else red Cross (X)
        }
    }
}

struct SearchGameRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameRow(game: ModelData().recentlySearched[0])
    }
}
