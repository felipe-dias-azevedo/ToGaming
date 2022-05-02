//
//  ContentView.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 30/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .config
    
    var body: some View {
        TabView(selection: $selection) {
            SearchHome()
                .tabItem {
                    IconLabel(title: "Search", icon: .magnifier)
                }
                .tag(Tab.search)
            
            ConfigHome()
                .tabItem {
                    IconLabel(title: "Config", icon: .gear)
                }
                .tag(Tab.config)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
