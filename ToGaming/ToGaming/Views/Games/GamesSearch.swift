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
            .listStyle(.inset)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        canceled.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
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
