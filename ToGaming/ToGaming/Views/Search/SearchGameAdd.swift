//
//  SearchGameAdd.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI
import CoreData

struct SearchGameAdd: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var game: FetchedResults<GameSearchCore>.Element
    @State private var games: [GameCore] = []
    
    @Binding var adding: Bool
    @State private var isFavorite: Bool = false
    @State private var favoritePlatform: Int = 0
    @State private var gameState: Game.Status = .toBuy
    @State private var score: Game.Score? = nil
    
    func addGameToLibrary() {
        let dateNow = Date()
        let newGame = GameCore(context: viewContext)
        newGame.id = UUID()
        newGame.igdbId = game.igdbId
        newGame.name = game.name!
        newGame.platforms = game.platforms!
        newGame.favoritePlatform = Int16(favoritePlatform)
        newGame.genres = game.genres
        newGame.publisher = game.publisher
        newGame.developer = game.developer
        newGame.insertDate = dateNow
        newGame.releaseDate = game.releaseDate!
        newGame.summary = game.summary
        newGame.storyline = game.storyline
        newGame.rating = game.rating
        newGame.ratingCount = game.ratingCount
        newGame.igdbReference = game.igdbReference
        newGame.isFavorite = isFavorite
        newGame.score = score?.rawValue ?? 0
        newGame.gameState = gameState.rawValue
        newGame.artworkImagesName = game.artworkImagesName
        newGame.coverImageName = game.coverImageName
        newGame.updateDate = dateNow
        try? viewContext.save()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        KeyValueText(key: "Name", value: game.name!)
                        KeyValueText(key: "Developer", value: game.developer!)
                        KeyValueText(key: "Rating", value: String.init(format: "%.2f%%", game.rating))
                        KeyValueText(key: "Release Date", value: DateHelper.toString(game.releaseDate!))
                    }
                    .padding(.vertical, 6)
                }
                
                Section(
                    header: Text("Fillable Game Data"),
                    footer: Text("User's Game Data Changeable After")
                ) {
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
                
                Section {
                    if let index = games.firstIndex(where: { $0.igdbId == game.igdbId })
                    {
                        Button {
                            withAnimation {
                                viewContext.delete(games[index])
                                PersistenceController().save(context: viewContext)
                                
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Remove Game")
                                    .fontWeight(.medium)
                                Label("Remove Game", systemImage: "minus")
                                    .labelStyle(.iconOnly)
                                Spacer()
                            }
                        }
                        .foregroundColor(.red)
                    } else {
                        Button {
                            withAnimation {
                                addGameToLibrary()
                                
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Add Game")
                                    .fontWeight(.medium)
                                Label("Add Game", systemImage: "plus")
                                    .labelStyle(.iconOnly)
                                Spacer()
                            }
                        }
                    }
                }
            }
            // TODO: Alert if cancelled pressed for then be sure data will be lost
            // TODO: Alert clicked add game and data is empty
            .onAppear(perform: {
                do {
                    let fetch: NSFetchRequest<GameCore> = GameCore.fetchRequest()
                    games = try viewContext.fetch(fetch)
                } catch {
                    games = []
                }
            })
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
        SearchGameAdd(game: GameSearchCore.example, adding: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
