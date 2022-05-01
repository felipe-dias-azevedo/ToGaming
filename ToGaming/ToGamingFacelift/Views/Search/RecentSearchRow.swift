//
//  SearchGameRow.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 01/05/22.
//

import SwiftUI

struct RecentSearchRow: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.gray)
                    .shadow(radius: 2)
                    
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("99%")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 6)
                            .background(.ultraThinMaterial)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
            }
            .frame(width: 75, height: 100)
            
            SearchRowContent()
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct SearchGameRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecentSearchRow()
            RecentSearchRow()
            RecentSearchRow()
        }
        .listStyle(.grouped)
        .preferredColorScheme(.dark)
    }
}
