//
//  SearchHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct SearchHome: View {
    
    @Binding var recentlySearched: [GameSearch]
    @State private var searchText = ""
    @State private var addingNew = false
    
    var searchResults: [GameSearch] {
        if searchText.isEmpty {
            return recentlySearched
        }
        return recentlySearched
            .filter { $0.name.uppercased().contains(searchText.uppercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { gameSearched in
                    NavigationLink(gameSearched.name) {
                        SearchGameDetail(gameSearched: gameSearched)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .toolbar {
                Button {
                    addingNew.toggle()
                } label: {
                    Label("New Game", systemImage: "plus")
                }
            }
            .sheet(isPresented: $addingNew) {
                NewGame(canceled: $addingNew)
            }
        }
    }
}

struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome(recentlySearched: .constant(ModelData().recentlySearched))
    }
}
