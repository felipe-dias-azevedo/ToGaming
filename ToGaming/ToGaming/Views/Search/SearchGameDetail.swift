//
//  SearchGameDetail.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import SwiftUI

struct SearchGameDetail: View {
    
    var gameSearched: GameSearch
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 10) {
                Text(gameSearched.name)
                    .font(.title)
                
                Text(gameSearched.platform)
                    .font(.headline)
            }
            
            Spacer()
            Divider()
            
            Text("Inserted in: \(DateHelper.toString(gameSearched.releaseDate))")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct SearchGameDetail_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameDetail(gameSearched: ModelData().recentlySearched[1])
    }
}
