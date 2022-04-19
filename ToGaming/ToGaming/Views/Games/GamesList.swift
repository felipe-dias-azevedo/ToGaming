//
//  GamesList.swift
//  ToGaming
//
//  Created by felipe azevedo on 22/03/22.
//

import SwiftUI

struct GamesList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var titleList: String
    var games: [FetchedResults<GameCore>.Element]
    @State private var searchText = ""
    
    var gamesSortedSearched: [GameCore] {
        let gamesSorted = games
            .sorted(by: {
                $0.insertDate!.compare($1.insertDate!) == .orderedDescending
            })
        
        if searchText.isEmpty || searchText.count < 3 {
            return gamesSorted
        }
        return gamesSorted
            .filter {
                $0.name!.lowercased().contains(searchText.lowercased())
            }
    }
        
    var body: some View {
        List {
            ForEach(gamesSortedSearched) { game in
                NavigationLink {
                    GameDetail(game: game)
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
            GamesList(titleList: "Example List", games: GameCore.examples)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
