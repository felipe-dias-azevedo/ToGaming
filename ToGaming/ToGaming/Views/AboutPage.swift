//
//  AboutPage.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        VStack {
            VStack(spacing: 4) {
                Text("Created By:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Felipe Azevedo")
                    .font(.title2)
            }
            .padding()
            
            Divider()
            
            VStack(spacing: 8) {
                Text("2022")
                    .foregroundColor(.gray)
                
                Text("Open Source")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
