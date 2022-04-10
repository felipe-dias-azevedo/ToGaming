//
//  ContentView.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(
            keyPath: \GameSearchCore.id,
            ascending: false)],
        animation: .default)
    private var gamesSearchCore: FetchedResults<GameSearchCore>
    @State private var selection: Tab = .games
    
    var games: [Game] {
        return gamesCore.map({ GameHelper.convert($0) })
    }
    
    enum Tab {
        case games
        case search
        case stats
        case config
    }
    
    var body: some View {
        TabView(selection: $selection) {
            GamesHome()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
                .tag(Tab.games)
            
            SearchHome()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            
            StatsHome()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
                .tag(Tab.stats)
            
            ConfigHome()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.config)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
