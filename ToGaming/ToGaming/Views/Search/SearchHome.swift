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
    
    let service = IgdbService()
    
    @State private var searchText = ""
    @State private var searchGamesResults: [GameNewSearch] = []
    @State private var addingNew = false
    @State private var filtering = false
    @State private var showAlert = false
    @State private var showError = false
    @State private var isLoading = false
    
    @State private var dateBeforeFilter: Date = Date()
    @State private var dateAfterFilter: Date = Date()
    @State private var platformFilter: String? = nil
    @State private var genreFilter: String? = nil
    @State private var publisherFilter: String? = nil
    @State private var developerFilter: String? = nil
    
    func searchGameBy() {
        isLoading = true
        if searchText.isEmpty {
            searchGamesResults = []
            isLoading = false
            return
        }
        service.config()
        service.searchGame(name: searchText) { gameSearchData in
            if let data = gameSearchData {
                if data.isEmpty {
                    showAlert = true
                } else {
                    searchGamesResults = data.compactMap({ GameNewSearch(
                        id: $0.id,
                        name: $0.name,
                        rating: $0.aggregatedRating,
                        releaseDate: DateHelper.toDate(from: $0.firstReleaseDate),
                        platforms: $0.platforms.map{ $0.name },
                        developer: $0.involvedCompanies
                            .first(where: { $0.developer })
                            .map({ $0.company.name })) })
                    .filter({ $0.developer != nil && $0.platforms.count > 0 })
                }
            } else {
                showError = true
            }
            isLoading = false
        }
    }
    
    var body: some View {
        NavigationView {
            SearchGameResults(
                searchResults: searchGamesResults,
                recentlySearched: recentlySearched.sorted(by: { $0.releaseDate! > $1.releaseDate! }),
                isLoading: isLoading)
                .alert("Search Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Confirm your Client ID and Secret Key on Configuration Tab")
                }
                .alert("Search Error", isPresented: $showError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("The app had an internal problem")
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
