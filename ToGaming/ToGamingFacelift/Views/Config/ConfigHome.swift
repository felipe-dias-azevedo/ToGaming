//
//  ConfigHome.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 01/05/22.
//

import SwiftUI

struct ConfigHome: View {
    
    @Environment(\.editMode) private var editMode
    
    @State private var name = ""
    @State private var platform = ""
    @State private var clientId = ""
    @State private var secretKey = ""
    
    @State private var editing: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            Form {
                ConfigFieldRow(value: $name, placeholder: "User Name", icon: .person, isEditing: editing.isEditing)
                
                ConfigFieldRow(value: $clientId, placeholder: "Client ID", icon: .personKey, isEditing: editing.isEditing)
                
                ConfigFieldRow(value: $secretKey, placeholder: "Secret Key", icon: .key, isEditing: editing.isEditing)
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Config")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editing)
        }
    }
}

struct ConfigHome_Previews: PreviewProvider {
    static var previews: some View {
        ConfigHome()
            .preferredColorScheme(.dark)
    }
}
