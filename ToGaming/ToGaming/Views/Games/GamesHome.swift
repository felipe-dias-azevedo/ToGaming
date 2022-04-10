//
//  GamesHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GamesHome: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(
            keyPath: \GameCore.id,
            ascending: false)],
        animation: .default)
    private var gamesCore: FetchedResults<GameCore>
    @State private var searching = false
    @State private var interval = 0
    @State private var intervals = [7, 15, 30, 90]
    
    var games: [Game] {
        return gamesCore.map({ GameHelper.convert($0) })
    }
    
    var gamesBest: Array<Game> {
        games.filter { $0.score?.rawValue ?? 0 > 4 && $0.rating > 90 && $0.isFavorite == true }
    }
    
    var gamesLaunchedRecently: Array<Game> {
        games.filter { $0.releaseDate >= DateHelper.toInterval(from: intervals[interval]) }
    }
    
    var gamesRecentlyAdded: Array<Game> {
        games.filter { $0.insertDate >= DateHelper.toInterval(from: intervals[interval]) }
    }
    
    var gamesRecentlyUpdated: Array<Game> {
        games.filter { $0.updateDate >= DateHelper.toInterval(from: intervals[interval]) && DateHelper.isNear(from: $0.wrappedValue.insertDate, to: $0.updateDate, between: 5) }
    }
    
    var gamesBoughtRecently: Array<Game> {
        games.filter { $game -> Bool in
            return $game.gameState != Game.Status.toBuy && $game.insertDate >= DateHelper.toInterval(from: intervals[interval])
        }
    }
    
    var gamesHighRatingScore: Array<Game> {
        games.filter { $game -> Bool in
            return $game.rating >= 70 && $game.score?.rawValue ?? 0 >= 4
        }
    }
    
    var gamesNotScoredPlayed: Array<Game> {
        games.filter { $game -> Bool in
            return $game.score == nil && $game.gameState == Game.Status.played
        }
    }
    
    var gamesNotScoredFavorites: Array<Game> {
        games.filter { $game -> Bool in
            return $game.score == nil && $game.isFavorite == true
        }
    }
    
    var gamesRecentViewed: Array<Game> {
        // TODO: Get only recent viewed games
        games.sorted(by: { $0.isFavorite && $1.isFavorite })
    }
    
    var body: some View {
        NavigationView {
            // TODO: Overview of favorite + recent games in summary box
                
            ScrollView(.vertical, showsIndicators: false) {
                    
                GameItem(title: "The Bests", games: gamesBest)

                GameItem(title: "Recently Added", games: gamesRecentlyAdded)

                GameItem(title: "Recently Updated", games: gamesRecentlyUpdated)

                GameItem(title: "Recently Launched", games: gamesLaunchedRecently)

                GameItem(title: "Bought Recently Added", games: gamesBoughtRecently)

                GameItem(title: "High Rating + Score", games: gamesHighRatingScore)

                GameItem(title: "Finished And Not Scored", games: gamesNotScoredPlayed)

                GameItem(title: "Favorites Not Scored", games: gamesNotScoredFavorites)
            
                VStack {
                    HStack {
                        Text("Recent Viewed")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    ForEach(gamesRecentViewed) { game in
                        Divider()
                        NavigationLink {
                            GameDetail(game: game)
                        } label: {
                            GameRow(game: game)
                                .padding(.trailing, 6)
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 18)
                .padding(.vertical, 16)
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
        GamesHome()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.light)
    }
}
