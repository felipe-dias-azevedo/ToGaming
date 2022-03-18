//
//  ConfigHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ConfigHome: View {
    @State var username: String
    @State var clientid: String
    @State var secretkey: String
    
    @State private var seeAbout = false
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("User Name")
                    TextField("User Name", text: $username)
                }
                
                Section(
                    header: Text("API Credentials"),
                    footer: Text("Store your API Credentials for searching for Games")
                ) {
                    HStack {
                        Text("Client ID")
                        SecureField("Client ID", text: $clientid)
                    }
                    
                    HStack {
                        Text("Secret Key")
                        SecureField("Secret Key", text: $secretkey)
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
        ConfigHome(username: String(), clientid: String(), secretkey: String())
    }
}
