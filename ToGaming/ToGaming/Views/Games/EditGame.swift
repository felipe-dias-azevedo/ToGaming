//
//  EditGame.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import SwiftUI

struct EditGame: View {
    
    @Binding var editing: Bool
    @Binding var game: Game
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Editable game data"),
                    footer: Text("Game data stored locally that can be changed")) {
                    
                        Toggle(isOn: $game.isFavorite) {
                            Text("Favorite Game")
                                .bold()
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            Text("Platform")
                                .bold()
                            TextField("Platform", text: $game.platform)
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            Text("Status")
                                .bold()
                            Spacer()
                            Picker("Status", selection: $game.gameState) {
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
                                    .bold()
                                Label("Score Star Icon", systemImage: "star.fill")
                                    .foregroundColor(.primary)
                                    .labelStyle(.iconOnly)
                            }
                                
                            Spacer()
                            
                            Picker("Score", selection: $game.score) {
                                ForEach(Game.Score.allCases) { status in
                                    Text(String(status.rawValue))
                                        .tag(status as Game.Score?)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                }
            }
            .navigationBarTitle(game.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Done") {
                        editing.toggle()
                    }
                }
            }
        }
    }
}

struct EditGame_Previews: PreviewProvider {
    static var previews: some View {
        EditGame(editing: .constant(true), game: .constant(ModelData().games[0]))
    }
}
