//
//  GamesList.swift
//  ToGaming
//
//  Created by felipe azevedo on 22/03/22.
//

import SwiftUI

struct GamesList: View {
    
    var titleList: String
    @Binding var games: [Game]
    @State private var searchText = ""
    
    var gamesSortedSearched: Array<Binding<Game>> {
        let gamesSorted = $games
            .sorted(by: {
                $0.wrappedValue.insertDate.compare($1.wrappedValue.insertDate) == .orderedDescending
            })
        
        if searchText.isEmpty || searchText.count < 3 {
            return gamesSorted
        }
        return gamesSorted
            .filter {
                $0.wrappedValue.name.lowercased().contains(searchText.lowercased())
            }
    }
        
    var body: some View {
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
        .navigationTitle(titleList)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GamesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GamesList(titleList: "Example List", games: .constant(ModelData().games))
        }
    }
}
