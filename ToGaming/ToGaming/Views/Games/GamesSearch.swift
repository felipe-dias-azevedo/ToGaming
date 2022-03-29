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
    
    var gamesSortedSearched: Array<Binding<Game>> {
        let gamesSorted = $games.sorted {
            $0.wrappedValue.isFavorite && !$1.wrappedValue.isFavorite
        }
        
        if searchText.isEmpty || searchText.count < 3 {
            return gamesSorted
        }
        return gamesSorted
            .filter { $0.wrappedValue .name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gamesSortedSearched) { $game in
                    NavigationLink {
                        GameDetail(game: $game)
                    } label: {
                        GameRow(game: game)
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Games")
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
