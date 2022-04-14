//
//  EditGame.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import SwiftUI

struct EditGame: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    @Binding var editing: Bool
    var game: FetchedResults<GameCore>.Element
    
    @State private var isFavorite: Bool = false
    @State private var favoritePlatform: Int16 = 0
    @State private var gameState: Game.Status = .toBuy
    @State private var score: Game.Score? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Editable game data"),
                    footer: Text("Game data stored locally that can be changed")) {
                    
                        Group {
                            Toggle(isOn: $isFavorite) {
                                Text("Favorite Game")
                                    .fontWeight(.medium)
                            }
                            
                            HStack(alignment: .center, spacing: 10) {
                                Text("Platform")
                                    .fontWeight(.medium)
                                Spacer()
                                Picker("Platform", selection: $favoritePlatform) {
                                    ForEach((0..<game.platforms!.count), id: \.self) { index in
                                        Label(game.platforms![index], systemImage: "star")
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
                                Picker("Status", selection: $gameState) {
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
                                
                                Picker("Score", selection: $score) {
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
                Section(
                    header: Text("View-only game data"),
                    footer: Text("Game data from IGDB that updates periodically")) {
                        
                        Group {
                            KeyValueText(key: "IGDB ID", value: String(game.igdbId ))
                            
                            KeyValueText(key: "Name", value: game.name!)
                            
                            KeyValueText(key: "Publisher", value: game.publisher!)
                            
                            KeyValueText(key: "Developer", value: game.developer!)
                            
                            KeyValueText(key: "Release Date", value: DateHelper.toString(game.releaseDate!))
                            
                            KeyValueText(key: "Rating", value: String.init(format: "%.2f%%", game.rating))
                            
                            KeyValueText(key: "Rating Count", value: String.init(format: "%.0f", game.ratingCount))
                            
                            if let url = game.igdbReference {
                                HStack(alignment: .center, spacing: 10) {
                                    Text("Data Source")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Button {
                                        openURL(url)
                                    } label: {
                                        HStack {
                                            Text("Go to IGDB")
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                            Label("Arrow Icon", systemImage: "arrow.right")
                                                .labelStyle(.iconOnly)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                
                Section {
                    Button {
                        withAnimation {
                            viewContext.delete(game)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        HStack {
                            Text("Remove Game")
                                .fontWeight(.medium)
                            Spacer()
                            Label("Remove Game", systemImage: "minus")
                                .labelStyle(.iconOnly)
                        }
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationBarTitle(game.name!)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Done") {
                        editing.toggle()
                        // FIXME: Update only when there's changes to game
                        game.updateDate = Date()
                    }
                }
            }
        }
    }
}

struct EditGame_Previews: PreviewProvider {
    static var previews: some View {
        EditGame(editing: .constant(true), game: GameCore.example)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
