//
//  GamesSearch.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import SwiftUI

struct GamesSearch: View {
    
    @Binding var games: [Game]
    @Binding var canceled: Bool
    @Environment(\.editMode) var editMode
    @State private var searchText = ""
    
    var gamesSortedSearched: [Game] {
        let gamesSort = games.sorted { $0.isFavorite && !$1.isFavorite }
        if searchText.isEmpty || searchText.count < 3 {
            return gamesSort
        }
        return gamesSort.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gamesSortedSearched) { game in
                    NavigationLink {
                        GameDetail()
                    } label: {
                        GameRow(game: game)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Done") {
                        canceled.toggle()
                    }
                }
            }
        }
    }
}

struct GamesSearch_Previews: PreviewProvider {
    static var previews: some View {
        GamesSearch(games: .constant(ModelData().games), canceled: .constant(false))
    }
}
