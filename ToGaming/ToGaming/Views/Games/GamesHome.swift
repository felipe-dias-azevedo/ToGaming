//
//  GamesHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GamesHome: View {
    
    @Binding var games: [Game]
    @State private var searching = false
    
    var gamesBought: [Game] {
        $games.wrappedValue.filter { game -> Bool in
            guard let state = game.gameState else { return false }
            return state != Game.GameStatus.toBuy
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                GameItem(title: "All Games", games: $games)
                
                GameItem(title: "Bought Games", games: .constant(gamesBought))
            }
            .listStyle(.inset)
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        searching.toggle()
                    } label: {
                        Label("Filter", systemImage: "magnifyingglass.circle")
                    }
                }
            }
            .sheet(isPresented: $searching) {
                GamesSearch(games: $games, canceled: $searching)
            }
        }
    }
}

struct GamesHome_Previews: PreviewProvider {
    static var previews: some View {
        GamesHome(games: .constant(ModelData().games))
    }
}
