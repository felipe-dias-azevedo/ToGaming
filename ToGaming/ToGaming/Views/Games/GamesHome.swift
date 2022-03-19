//
//  GamesHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GamesHome: View {
    
    @Binding var games: [Game]
    @Environment(\.editMode) var editMode
    
    var gamesSorted: [Game] {
        games.sorted { $0.isFavorite && !$1.isFavorite }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gamesSorted) { game in
                    NavigationLink {
                        GameDetail()
                    } label: {
                        GameRow(game: game)
                    }
                }
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EditGame()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

struct GamesHome_Previews: PreviewProvider {
    static var previews: some View {
        GamesHome(games: .constant(ModelData().games))
    }
}
