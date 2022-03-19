//
//  GameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct GameRow: View {
    
    var game: Game
    
    var body: some View {
        HStack {
            game.image
                .resizable()
                .frame(width: 88.88, height: 50)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(game.name)
                    .font(.subheadline)
                
                Text(game.platform)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 2)
            
            Spacer()
            
            Image(systemName: "cart.fill")
                .foregroundColor(.blue)
            
            if (game.isFavorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: ModelData().games[0])
            .previewLayout(.fixed(width: 300, height: 60))
        
        GameRow(game: ModelData().games[3])
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
