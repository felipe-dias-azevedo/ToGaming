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
                HStack {
                    Text("User Name")
                    TextField("User Name", text: $userConfig.userName)
                }
                
                Section(
                    header: Text("API Credentials"),
                    footer: Text("Store your API Credentials for searching for Games")
                ) {
                    HStack {
                        Text("Client ID")
                        SecureField("Client ID", text: $userConfig.clientId)
                    }
                    
                    HStack {
                        Text("Secret Key")
                        SecureField("Secret Key", text: $userConfig.secretKey)
                    }
                }
            }
            .toolbar {
                Button("About") {
                    seeAbout.toggle()
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $seeAbout) {
                AboutPage()
            }
        }
    }
}

struct ConfigHome_Previews: PreviewProvider {
    static var previews: some View {
        ConfigHome(userConfig: .constant(ModelData().userConfig))
    }
}
