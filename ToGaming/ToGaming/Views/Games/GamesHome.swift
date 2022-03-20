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
    
    var body: some View {
        NavigationView {
            List {
                ForEach($games) { game in
                    // TODO: Change it to Scroll View and Preview of recent games based on category, platform, etc
                    NavigationLink {
                        GameDetail()
                    } label: {
                        GameCard(game: game)
                    }
                }
            }
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
