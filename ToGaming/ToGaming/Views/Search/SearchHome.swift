//
//  SearchHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct SearchHome: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var searchText = ""
    @State private var addingNew = false
    @State private var filtering = false
    
    @State private var dateBeforeFilter: Date = Date()
    @State private var dateAfterFilter: Date = Date()
    @State private var platformFilter: String? = nil
    @State private var genreFilter: String? = nil
    @State private var publisherFilter: String? = nil
    @State private var developerFilter: String? = nil
    
    var isRecentsSearchs: Bool {
        return searchText.isEmpty
    }
    
    var searchResults: [GameSearch] {
        let recentlySearched = modelData.recentlySearched
        if isRecentsSearchs {
            return recentlySearched
        }
        return recentlySearched
            .filter { $0.name.uppercased().contains(searchText.uppercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                if isRecentsSearchs {
                    ForEach(searchResults, id: \.self) { gameSearched in
                        NavigationLink {
                            SearchGameDetail(game: gameSearched, isRecentSearched: isRecentsSearchs)
                        } label: {
                            RecentlySearchedGameRow(game: gameSearched)
                        }
                    }
                    .onDelete(perform: { searchesToDelete in
                        searchesToDelete
                            .map({ searchResults[$0].id })
                            .forEach({ searchToDelete in
                                modelData.recentlySearched.removeAll(where: { $0.id == searchToDelete })
                            })
                    })
                }
                else {
                    ForEach(searchResults, id: \.self) { gameSearched in
                        NavigationLink {
                            SearchGameDetail(game: gameSearched, isRecentSearched: isRecentsSearchs)
                        } label: {
                            SearchGameRow(game: gameSearched)
                        }
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
                SearchFilter(filtering: $filtering, dateAfter: $dateAfterFilter, dateBefore: $dateBeforeFilter, selectedPlatform: $platformFilter, selectedGenre: $genreFilter, selectedPublishers: $publisherFilter, selectedDevelopers: $developerFilter)
            }
        }
    }
}

struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome()
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
