//
//  GamesSearch.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import SwiftUI

struct GamesSearch: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @Binding var canceled: Bool
    @State private var showFavoritesOnly = false
    @State private var filter = FilterStatus.all
    @State private var searchText = ""
    
    var gamesSortedSearched: Array<Binding<Game>> {
        let gamesSorted = $modelData.games
            .sorted { $0.wrappedValue.isFavorite && !$1.wrappedValue.isFavorite }
            .filter({ game in
                (!showFavoritesOnly || game.isFavorite.wrappedValue) && (filter == .all || filter.rawValue == game.gameState.wrappedValue.rawValue) })
        
        if searchText.isEmpty || searchText.count < 3 {
            return gamesSorted
        }
        return gamesSorted
            .filter { $0.wrappedValue .name.lowercased().contains(searchText.lowercased()) }
    }
    
    enum FilterStatus: String, CaseIterable, Identifiable {
        case all = "All"
        case playing = "Playing"
        case played = "Played"
        case toPlay = "To Play"
        case toBuy = "To Buy"
        
        var id: FilterStatus { self }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gamesSortedSearched) { $game in
                    NavigationLink {
                        GameDetail(game: $game)
                    } label: {
                        GameRow(game: game)
                    }
                }
                .onDelete(perform: { gamesToDelete in
                    // FIXME: If deleted from parent component, it doesnt show delete action anymore
                    gamesToDelete
                        .map({ gamesSortedSearched[$0].id })
                        .forEach({ gameToDelete in
                            modelData.games.removeAll(where: { $0.id == gameToDelete })
                        })
                })
            }
            .listStyle(.inset)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Saved Games")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Status", selection: $filter) {
                            ForEach(FilterStatus.allCases) { status in
                                if status == .all {
                                    Text(status.rawValue)
                                        .tag(status)
                                } else {
                                    Label(status.rawValue, systemImage: StatusToIcon.name(status.rawValue))
                                        .labelStyle(.titleAndIcon)
                                        .tag(status)
                                }
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Favorites only", systemImage: "heart.fill")
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        canceled.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
}

struct GamesSearch_Previews: PreviewProvider {
    static var previews: some View {
        GamesSearch(canceled: .constant(false))
            .environmentObject(ModelData())
    }
}
