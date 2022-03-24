//
//  AboutPage.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct AboutPage: View {
    
    @Binding var showingCanceled: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // TODO: Add App icon + App Name on top of information
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Created By:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Felipe Azevedo")
                            .font(.title)
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Open Source GPL-3")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("2022")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                .padding(.top, 10)
                
                Divider()
                
                Text("Version 0.1")
                
                Spacer()
                
                // TODO: Button to read license on Github
                // TODO: Button to redirect to repo on Github
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingCanceled.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage(showingCanceled: .constant(true))
    }
}
