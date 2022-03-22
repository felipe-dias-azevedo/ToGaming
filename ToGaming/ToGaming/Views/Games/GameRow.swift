//
//  GameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct GameRow: View {
    
    var game: Game
    
    var iconStatus: String {
        switch (game.gameState) {
            case .toBuy:
                return "cart.fill"
            case .playing:
                return "play.fill"
            case .played:
                return "checkmark.circle.fill"
            case .toPlay:
                return "forward.frame.fill"
            default:
                return "questionmark.circle.fill"
        }
    }
    
    var body: some View {
        HStack {
            game.image
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
            
            Image(systemName: iconStatus)
                .accessibilityLabel(game.gameState?.rawValue ?? "Undefined State")
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
