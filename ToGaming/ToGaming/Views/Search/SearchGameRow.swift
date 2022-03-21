//
//  SearchGameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct SearchGameRow: View {
    
    var searchGame: GameSearch
    
    var body: some View {
        Text(searchGame.name)
    }
}

struct SearchGameRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameRow(searchGame: ModelData().recentlySearched[0])
    }
}
