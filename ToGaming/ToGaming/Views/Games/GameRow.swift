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
            Image(game.artworkImagesName[0])
                .resizable()
                .frame(width: 88.88, height: 50)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(game.name)
                    .foregroundColor(.primary)
                
                Text(game.platform)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: StatusToIcon.name(game.gameState))
                .accessibilityLabel(game.gameState.rawValue)
                .foregroundColor(.blue)
            
            if (game.isFavorite) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: ModelData().games[0])
            .previewLayout(.fixed(width: 300, height: 60))
        
        GameRow(game: ModelData().games[1])
            .previewLayout(.fixed(width: 300, height: 60))
            .preferredColorScheme(.dark)
        
        GameRow(game: ModelData().games[2])
            .previewLayout(.fixed(width: 300, height: 60))
        
        GameRow(game: ModelData().games[3])
            .previewLayout(.fixed(width: 300, height: 60))
            .preferredColorScheme(.dark)
    }
}
