//
//  NewGame.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct NewGame: View {
    
    @Binding var canceled: Bool
    @State var game: Game
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    FormField(title: "Name", placeholder: "Ex: Grand Theft Auto", textField: $game.name)
                    
                    //FormField(title: "Platform", placeholder: "Ex: Playstation 4", textField: $game.favoritePlatform)
                    
                    HStack {
                        Toggle(isOn: $game.isFavorite) {
                            Text("Favorite")
                        }
                    }
                    
                    // TODO: WIP Form with data to add new game locally
                    // TODO: Add Score, gameState and Image in Form
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Cancel") {
                        // TODO: Show alert that data will be lost if canceled
                        canceled.toggle()
                    }
                }
                
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Save") {
                        // TODO: Save new game locally
                        canceled.toggle()
                    }
                }
            }
            .navigationBarTitle("Add New Game")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        NewGame(canceled: .constant(false), game: .new)
    }
}
