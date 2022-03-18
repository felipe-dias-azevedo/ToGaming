//
//  GameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct GameRow: View {
    var isFavorite = true
    
    var body: some View {
        HStack {
            Image("tw")
                .resizable()
                .frame(width: 88.88, height: 50)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("God of War")
                    .bold()
                
                Text("Playstation 4")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 2)
            
            Spacer()
            
            Image(systemName: "cart.fill")
                .foregroundColor(.blue)
            
            if (isFavorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow()
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
