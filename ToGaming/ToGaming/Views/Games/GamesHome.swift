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
    @State private var dateInterval = Date.now.addingTimeInterval(-TimeInterval(604800))
    
    var recentGames: [Game] {
        $games.wrappedValue.filter { $0.insertDate >= dateInterval }
    }
    
    var gamesBought: [Game] {
        $games.wrappedValue.filter { game -> Bool in
            guard let state = game.gameState else { return false }
            return state != Game.GameStatus.toBuy
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // TODO: Overview of favorite + recent games in summary box
                
                GameItem(title: "Recent Games", games: .constant(recentGames))
                
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
            .preferredColorScheme(.dark)
    }
}
