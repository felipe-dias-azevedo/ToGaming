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
    @State private var searchGamesResults: [GameSearchCore] = []
    @State private var addingNew = false
    @State private var filtering = false
    @State private var showAlert = false
    
    @State private var dateBeforeFilter: Date = Date()
    @State private var dateAfterFilter: Date = Date()
    @State private var platformFilter: String? = nil
    @State private var genreFilter: String? = nil
    @State private var publisherFilter: String? = nil
    @State private var developerFilter: String? = nil
    
    func searchGameBy() {
        if searchText.isEmpty {
            searchGamesResults = []
            return
        }
        // TODO: Search game on IGDB
        searchGamesResults = recentlySearched.filter { $0.name!.uppercased().contains(searchText.uppercased()) }
    }
    
    var body: some View {
        NavigationView {
            SearchGameResults(searchResults: searchGamesResults, recentlySearched: recentlySearched.sorted(by: { $0.releaseDate! > $1.releaseDate! }))
                .alert("Search Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Confirm your Client ID and Secret Key on Configuration Tab")
                }
                .listStyle(.grouped)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: nil)
                .onSubmit(of: .search) {
                    searchGameBy()
                }
                .onAppear {
                    searchGameBy()
                }
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
