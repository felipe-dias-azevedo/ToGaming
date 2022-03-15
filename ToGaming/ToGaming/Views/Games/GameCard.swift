//
//  GameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GameCard: View {
    var body: some View {
        HStack {
            Image("tw")
                .resizable()
                .frame(width: 141.6, height: 80)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("God of War")
                    .font(.headline)
                    .bold()
                
                Text("Playstation 4")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "")
        }
        .padding(.vertical, 4)
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCard()
            .previewLayout(.fixed(width: 360, height: 90))
    }
}
