//
//  SearchGameAdd.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI

struct SearchGameAdd: View {
    
    var game: GameSearch
    @Binding var adding: Bool
    @State private var gameToAdd: Game = .new
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        KeyValueText(key: "Name", value: game.name)
                        KeyValueText(key: "Developer", value: game.developer)
                        KeyValueText(key: "Rating", value: String.init(format: "%.2f%%", game.rating))
                        KeyValueText(key: "Release Date", value: DateHelper.toString(game.releaseDate))
                    }
                    .padding(.vertical, 6)
                }
                
                Section(
                    header: Text("Fillable Game Data"),
                    footer: Text("User's Game Data Changeable After")
                ) {
                    Group {
                        Toggle(isOn: $gameToAdd.isFavorite) {
                            Text("Favorite Game")
                                .fontWeight(.medium)
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            Text("Platform")
                                .fontWeight(.medium)
                            Spacer()
                            Picker("Platform", selection: $gameToAdd.favoritePlatform) {
                                ForEach((0..<game.platforms.count), id: \.self) { index in
                                    Label(game.platforms[index], systemImage: "star")
                                        .labelStyle(.titleOnly)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            Text("Status")
                                .fontWeight(.medium)
                            Spacer()
                            Picker("Status", selection: $gameToAdd.gameState) {
                                ForEach(Game.Status.allCases) { status in
                                    Label(status.rawValue, systemImage: StatusToIcon.name(status))
                                        .labelStyle(.titleAndIcon)
                                        .tag(status)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            HStack(alignment: .center, spacing: 4) {
                                Text("Score")
                                    .fontWeight(.medium)
                                Label("Score Star Icon", systemImage: "star.fill")
                                    .foregroundColor(.primary)
                                    .labelStyle(.iconOnly)
                            }
                                
                            Spacer()
                            
                            Picker("Score", selection: $gameToAdd.score) {
                                ForEach(Game.Score.allCases) { status in
                                    Text(String(status.rawValue))
                                        .tag(status as Game.Score?)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    .padding(.vertical, 6)
                }
                
                Section {
                    Button("Add Game") {
                        // TODO: Include game data to gameToAdd in adding to library
                    }
                }
            }
            // TODO: Alert if cancelled pressed for then be sure data will be lost
            // TODO: Alert clicked add game and data is empty
            .navigationBarTitle("Get Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        adding.toggle()
                    }
                }
            }
        }
    }
}

struct SearchGameAdd_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameAdd(game: ModelData().recentlySearched[0], adding: .constant(true))
    }
}
