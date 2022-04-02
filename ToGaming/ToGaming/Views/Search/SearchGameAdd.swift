//
//  SearchGameAdd.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI

struct SearchGameAdd: View {
    
    var game: GameSearch
    
    var body: some View {
        Text("Form data to add essential data to game in library")
    }
}

struct SearchGameAdd_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameAdd(game: ModelData().recentlySearched[0])
    }
}
