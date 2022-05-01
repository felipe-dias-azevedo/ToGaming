//
//  SearchRowContent.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 01/05/22.
//

import SwiftUI

struct SearchRowContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Game Name Example")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                
            Text("Game Platforms Example")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .padding(.top, 2)
                
            Text("Publisher Name Example")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .padding(.top, 2)
                
            Text("99/99/9999")
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(.top, 6)
        }
    }
}

struct SearchRowContent_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SearchRowContent()
        }
        .listStyle(.grouped)
    }
}
