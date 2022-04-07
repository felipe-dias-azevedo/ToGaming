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
    @State private var interval = 0
    @State private var intervals = [7, 15, 30, 90]
    
    var recentGamesAvailable: Array<Binding<Game>> {
        $games.filter { $0.wrappedValue.insertDate >= DateHelper.toInterval(from: intervals[interval]) }
    }
    
    var gamesBought: Array<Binding<Game>> {
        $games.filter { $game -> Bool in
            return $game.gameState.wrappedValue != Game.Status.toBuy
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // TODO: Overview of favorite + recent games in summary box
                
                GameItem(title: "Recent Games", games: recentGamesAvailable)
                
                GameItem(title: "Bought Games", games: gamesBought)
                
                // TODO: Recent games on list on bottom
            }
            .listStyle(.inset)
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        searching.toggle()
                    } label: {
                        Label("Saved Search", systemImage: "magnifyingglass.circle")
                            .labelStyle(.iconOnly)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Days", selection: $interval) {
                            ForEach((0..<intervals.count), id: \.self) { index in
                                Text("\(intervals[index]) Days")
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Label("\(intervals[interval]) Days", systemImage: "ellipsis.circle")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
            .sheet(isPresented: $searching) {
                GamesSearch(canceled: $searching)
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
