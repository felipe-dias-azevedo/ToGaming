//
//  GameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GameCard: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let game: FetchedResults<GameCore>.Element
    
    var body: some View {
        VStack(alignment: .leading) {
            RemoteImage(url: ImageHelper.toURL(game.artworkImagesName!.first!), type: .card)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center) {
                    Text(game.name!)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .bold()
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if game.isFavorite {
                        Label("Game Favorite", systemImage: "heart.fill")
                            .labelStyle(.iconOnly)
                            .font(.body)
                            .foregroundColor(.red)
                    }
                }
                
                HStack(alignment: .center) {
                    Text(game.platforms![Int(game.favoritePlatform)])
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Image(systemName: StatusToIcon.name(Game.Status.init(rawValue: game.gameState!)!))
                        .font(.caption)
                        .accessibilityLabel(Game.Status.init(rawValue: game.gameState!)!.rawValue)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    if let score = Game.Score.init(rawValue: game.score) {
                        HStack(alignment: .center, spacing: 2) {
                            Text(String(score.rawValue))
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding(.horizontal, 4)
            .frame(width: 195.55)
        }
        .padding(.horizontal, 5)
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameCard(game: GameCore.example)
            
            GameCard(game: GameCore.example)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 230, height: 180))
    }
}
