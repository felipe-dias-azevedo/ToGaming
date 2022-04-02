//
//  ContentView.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var selection: Tab = .search
    
    enum Tab {
        case games
        case search
        case stats
        case config
    }
    
    var body: some View {
        TabView(selection: $selection) {
            GamesHome(games: $modelData.games)
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
                .tag(Tab.games)
            
            SearchHome(recentlySearched: $modelData.recentlySearched)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            
            StatsHome()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
                .tag(Tab.stats)
            
            ConfigHome(userConfig: $modelData.userConfig)
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
            .environmentObject(ModelData())
            .previewInterfaceOrientation(.portrait)
    }
}
