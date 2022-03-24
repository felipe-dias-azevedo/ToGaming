//
//  ConfigHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ConfigHome: View {
    
    @Binding var userConfig: UserConfig
    
    @State private var seeAbout = false
    
    var body: some View {
        NavigationView {
            Form {
                FormField(title: "User Name", textField: $userConfig.userName)
                
                Section(
                    header: Text("API Credentials"),
                    footer: Text("Store your API Credentials for searching for Games")
                ) {
                    FormField(title: "Client ID", textField: $userConfig.clientId)
                    
                    FormField(title: "Secret Key", textField: $userConfig.secretKey)
                }
            }
            .toolbar {
                Button("About") {
                    seeAbout.toggle()
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $seeAbout) {
                AboutPage(showingCanceled: $seeAbout)
            }
        }
    }
}

struct ConfigHome_Previews: PreviewProvider {
    static var previews: some View {
        ConfigHome(userConfig: .constant(ModelData().userConfig))
    }
}
