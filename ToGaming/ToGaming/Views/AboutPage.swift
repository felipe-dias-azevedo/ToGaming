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
                
                VStack {
                    Image("togaming")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(16)
                        .shadow(radius: 2)
                        
                    Text("ToGaming")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.top, 8)
                }
                .padding(.bottom, 32)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Created By:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Felipe Azevedo")
                            .font(.title2)
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Open Source GPL-3")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("2022")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                .padding(.top, 10)
                
                Divider()
                    .padding(.horizontal, 18)
                
                
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    Text("Version \(version)")
                        .padding(.top, 10)
                }
                
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
            .padding(.vertical, 32)
            .padding(.horizontal, 10)
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage(showingCanceled: .constant(true))
    }
}
