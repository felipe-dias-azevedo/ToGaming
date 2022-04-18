//
//  ConfigHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ConfigHome: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) private var editMode
    
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var userConfig: FetchedResults<UserConfigCore>
    
    @State private var userName: String = ""
    @State private var preferredPlatform: String = ""
    @State private var clientId: String = ""
    @State private var secretKey: String = ""
    
    @State private var seeAbout = false
    @State private var editing: EditMode = .inactive
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            Form {
                EditFormField(title: "User Name", textField: userName, isEditing: editing.isEditing) {
                    TextField("User Name", text: $userName)
                }
                
                // TODO: Change way to select preferred platform (select from igdb all platforms available)
                
                EditFormField(title: "Preferred Platform", textField: preferredPlatform, isEditing: editing.isEditing) {
                    TextField("Preferred Platform", text: $preferredPlatform)
                }
                
                // TODO: Change which modes to show in GamesHome (select which to see)
                
                Section(
                    header: Text("API Credentials"),
                    footer: Text("Store your API Credentials for searching for Games")
                ) {
                    EditFormField(title: "Client ID", textField: clientId, isEditing: editing.isEditing) {
                        TextField("Client ID", text: $clientId)
                    }
                    
                    EditFormField(title: "Secret Key", textField: secretKey, isEditing: editing.isEditing) {
                        TextField("Secret Key", text: $secretKey)
                    }
                }
            }
            .alert("Data Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("The app had a internal problem")
            }
            .onAppear {
                if let user = userConfig.first {
                    userName = user.userName!
                    preferredPlatform = user.preferredPlatform!
                    clientId = user.clientId!
                    secretKey = user.secretKey!
                } else {
                    let newUserConfig = UserConfigCore(context: viewContext)
                    newUserConfig.userName = userName
                    newUserConfig.preferredPlatform = preferredPlatform
                    newUserConfig.clientId = clientId
                    newUserConfig.secretKey = secretKey
                    do {
                        try viewContext.save()
                    } catch {
                        showError = true
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                        .onChange(of: editing, perform: {newValue in
                            if let user = userConfig.first {
                                user.userName = userName
                                user.preferredPlatform = preferredPlatform
                                user.clientId = clientId
                                user.secretKey = secretKey
                                do {
                                    try viewContext.save()
                                } catch {
                                    showError = true
                                }
                            }
                        })
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("About") {
                        seeAbout.toggle()
                    }
                }
            }
            .navigationViewStyle(.stack)
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
        ConfigHome()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
