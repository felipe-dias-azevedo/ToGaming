//
//  SearchGameResults.swift
//  ToGaming
//
//  Created by felipe azevedo on 15/04/22.
//

import SwiftUI

struct SearchGameResults: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.isSearching) private var isSearching
    
    let searchResults: [GameNewSearch]
    let recentlySearched: [GameSearchCore]
    let isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            List {
                if !isSearching {
                    Section(header: Text("Recently Searched")) {
                        ForEach(recentlySearched, id: \.self) { gameSearched in
                            NavigationLink {
                                SearchGameDetail(game: gameSearched, isRecentSearched: recentlySearched.isEmpty)
                            } label: {
                                RecentlySearchedGameRow(game: gameSearched)
                            }
                            // TODO: Swipe Actions with focused value (like apple landmarks)
                        }
                        .onDelete(perform: { offsets in
                            withAnimation {
                                offsets.map{ recentlySearched[$0] }.forEach(viewContext.delete)
                                PersistenceController().save(context: viewContext)
                            }
                        })
                    }
                }
                else {
                    Section(footer: Text("\(searchResults.count) Results")) {
                        ForEach(searchResults, id: \.self) { result in
                            NavigationLink {
                                SearchGameNewDetail(igdbGameId: result.id)
                            } label: {
                                SearchGameRow(game: result)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SearchGameResults_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchGameResults(searchResults: [GameNewSearch(id: 1, name: "Game 1", rating: 10.0, releaseDate: Date(), platforms: ["Playstation 4", "Xbox One", "PC"], developer: "Developer 1")], recentlySearched: GameSearchCore.examples, isLoading: false)
                .searchable(text: .constant(""))
                .listStyle(.grouped)
                .navigationViewStyle(.stack)
                .navigationTitle("Search")
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
