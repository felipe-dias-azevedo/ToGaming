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
    @State private var filtering = false
    
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
                    NavigationLink {
                        //SearchGameDetail(game: gameSearched)
                    } label: {
                        SearchGameRow(searchGame: gameSearched)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Search")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        filtering.toggle()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        addingNew.toggle()
                    } label: {
                        Label("New Game", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $addingNew) {
                NewGame(canceled: $addingNew, game: .new)
            }
            .sheet(isPresented: $filtering) {
                SearchFilter()
            }
        }
    }
}

struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome(recentlySearched: .constant(ModelData().recentlySearched))
            .preferredColorScheme(.dark)
    }
}
