//
//  GameRow.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import SwiftUI

struct GameRow: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let game: FetchedResults<GameCore>.Element
    
    var body: some View {
        HStack {
            RemoteImage(url: ImageHelper.toURL(game.artworkImagesName!.first!), type: .row)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(game.name!)
                    .foregroundColor(.primary)
                
                Text(game.platforms![Int(game.favoritePlatform)])
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: StatusToIcon.name(Game.Status.init(rawValue: game.gameState!)!))
                .accessibilityLabel(Game.Status.init(rawValue: game.gameState!)!.rawValue)
                .foregroundColor(.blue)
            
            if game.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameRow(game: GameCore.example)
            
            GameRow(game: GameCore.example)
                .preferredColorScheme(.dark)
            
            GameRow(game: GameCore.example)
            
            GameRow(game: GameCore.example)
                .preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
