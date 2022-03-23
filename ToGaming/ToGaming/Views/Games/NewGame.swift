//
//  NewGame.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct NewGame: View {
    
    @Binding var canceled: Bool
    
    var body: some View {
        NavigationView {
            Form {
                // TODO: Form with data to add new game locally
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
        NewGame(canceled: .constant(false))
    }
}
