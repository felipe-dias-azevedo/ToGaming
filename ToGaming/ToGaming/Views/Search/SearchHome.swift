//
//  SearchHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct SearchHome: View {
    
    let games = ["GT7", "GOW", "TLOU2"]
    @State private var searchText = ""
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return games
        }
        return games
            .map { $0.uppercased() }
            .filter { $0.contains(searchText.uppercased()) }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink(destination: Text(name)) {
                            Text(name)
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Search New Games")
                .toolbar {
                    NavigationLink {
                        NewGame()
                    } label: {
                        Label("New Game", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome()
    }
}
