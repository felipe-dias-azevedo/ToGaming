//
//  SearchHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct SearchHome: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GameCore.id, ascending: true)], animation: .default)
    private var recentlySearched: FetchedResults<GameSearchCore>
    
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
    
    var searchResults: [GameSearchCore] {
        if isRecentsSearchs {
            // TODO: Sort by "insert date" on memory of recent searches
            return recentlySearched.sorted(by: { $0.releaseDate! > $1.releaseDate! })
        }
        return recentlySearched
            .filter { $0.name!.uppercased().contains(searchText.uppercased()) }
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
                        // TODO: Swipe Actions with focused value (like apple landmarks)
                    }
                    .onDelete(perform: { offsets in
                        withAnimation {
                            offsets.map{ searchResults[$0] }.forEach(viewContext.delete)
                            PersistenceController().save(context: viewContext)
                        }
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
            .navigationViewStyle(.stack)
            .navigationTitle("Search")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        filtering.toggle()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button {
//                        addingNew.toggle()
//                    } label: {
//                        Label("New Game", systemImage: "square.and.pencil")
//                    }
//                }
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
