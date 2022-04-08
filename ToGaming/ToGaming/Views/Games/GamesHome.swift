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
    
    var gamesBest: Array<Binding<Game>> {
        $games.filter { $0.score.wrappedValue?.rawValue ?? 0 > 4 && $0.rating.wrappedValue > 90 && $0.isFavorite.wrappedValue == true }
    }
    
    var gamesLaunchedRecently: Array<Binding<Game>> {
        $games.filter { $0.wrappedValue.releaseDate >= DateHelper.toInterval(from: intervals[interval]) }
    }
    
    var gamesRecentlyAdded: Array<Binding<Game>> {
        $games.filter { $0.wrappedValue.insertDate >= DateHelper.toInterval(from: intervals[interval]) }
    }
    
    var gamesRecentlyUpdated: Array<Binding<Game>> {
        $games.filter { $0.wrappedValue.updateDate >= DateHelper.toInterval(from: intervals[interval]) && DateHelper.isNear(from: $0.wrappedValue.insertDate, to: $0.wrappedValue.updateDate, between: 5) }
    }
    
    var gamesBoughtRecently: Array<Binding<Game>> {
        $games.filter { $game -> Bool in
            return $game.gameState.wrappedValue != Game.Status.toBuy && $game.insertDate.wrappedValue >= DateHelper.toInterval(from: intervals[interval])
        }
    }
    
    var gamesHighRatingScore: Array<Binding<Game>> {
        $games.filter { $game -> Bool in
            return $game.rating.wrappedValue >= 70 && $game.score.wrappedValue?.rawValue ?? 0 >= 4
        }
    }
    
    var gamesNotScoredPlayed: Array<Binding<Game>> {
        $games.filter { $game -> Bool in
            return $game.score.wrappedValue == nil && $game.gameState.wrappedValue == Game.Status.played
        }
    }
    
    var gamesNotScoredFavorites: Array<Binding<Game>> {
        $games.filter { $game -> Bool in
            return $game.score.wrappedValue == nil && $game.isFavorite.wrappedValue == true
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // TODO: Overview of favorite + recent games in summary box
                
                GameItem(title: "The Bests", games: gamesBest)
                
                GameItem(title: "Recently Added", games: gamesRecentlyAdded)
                
                GameItem(title: "Recently Updated", games: gamesRecentlyUpdated)
                
                GameItem(title: "Recently Launched", games: gamesLaunchedRecently)
                
                GameItem(title: "Bought Recently Added", games: gamesBoughtRecently)
                
                GameItem(title: "High Rating + Score", games: gamesHighRatingScore)
                
                GameItem(title: "Finished And Not Scored", games: gamesNotScoredPlayed)
                
                GameItem(title: "Favorites Not Scored", games: gamesNotScoredFavorites)
                
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
