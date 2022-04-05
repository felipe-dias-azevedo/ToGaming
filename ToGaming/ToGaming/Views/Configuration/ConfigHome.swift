//
//  ConfigHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ConfigHome: View {
    
    @Environment(\.editMode) private var editMode
    
    @Binding var userConfig: UserConfig
    @State private var seeAbout = false
    @State private var editing: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            Form {
                EditFormField(title: "User Name", textField: $userConfig.userName, isEditing: editing.isEditing)
                
                EditFormField(title: "Preferred Platform", textField: $userConfig.preferredPlatform, isEditing: editing.isEditing)
                
                // TODO: Change which modes to show in GamesHome (select which to see)
                
                Section(
                    header: Text("API Credentials"),
                    footer: Text("Store your API Credentials for searching for Games")
                ) {
                    EditFormField(title: "Client ID", textField: $userConfig.clientId, isEditing: editing.isEditing)
                    
                    EditFormField(title: "Secret Key", textField: $userConfig.secretKey, isEditing: editing.isEditing)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("About") {
                        seeAbout.toggle()
                    }
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $seeAbout) {
                AboutPage(showingCanceled: $seeAbout)
            }
            .environment(\.editMode, $editing)
        }
    }
}

struct ConfigHome_Previews: PreviewProvider {
    static var previews: some View {
        ConfigHome(userConfig: .constant(ModelData().userConfig))
    }
}
