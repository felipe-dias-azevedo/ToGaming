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
    
    var searchResults: [GameSearchCore]
    var recentlySearched: [GameSearchCore]
    
    var body: some View {
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
                    ForEach(searchResults, id: \.self) { gameSearched in
                        NavigationLink {
                            SearchGameDetail(game: gameSearched, isRecentSearched: recentlySearched.isEmpty)
                        } label: {
                            SearchGameRow(game: gameSearched)
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
            SearchGameResults(searchResults: GameSearchCore.examples, recentlySearched: GameSearchCore.examples)
                .searchable(text: .constant(""))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
