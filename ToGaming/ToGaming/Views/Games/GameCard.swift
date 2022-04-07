//
//  GameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GameCard: View {
    
    var game: Game
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(game.artworkImagesName[0])
                .renderingMode(.original)
                .resizable()
                .frame(width: 195.55, height: 110)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center) {
                    Text(game.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .bold()
                    
                    Spacer()
                    
                    if game.isFavorite {
                        Label("Game Favorite", systemImage: "heart.fill")
                            .labelStyle(.iconOnly)
                            .font(.body)
                            .foregroundColor(.red)
                    }
                }
                
                HStack(alignment: .center) {
                    Text(game.platforms[game.favoritePlatform])
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: StatusToIcon.name(game.gameState))
                        .font(.caption)
                        .accessibilityLabel(game.gameState.rawValue)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    if let score = game.score {
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
            GameCard(game: ModelData().games[0])
                .previewLayout(.fixed(width: 230, height: 180))
            
            GameCard(game: ModelData().games[2])
                .previewLayout(.fixed(width: 230, height: 180))
                .preferredColorScheme(.dark)
            
            GameCard(game: Game(id: UUID(), name: "Grand Theft Auto V", platforms: ["Playstation 4"], favoritePlatform: 0, genres: [], publisher: "", developer: "", insertDate: Date(), releaseDate: Date(), summary: "", rating: 0.0, ratingCount: 0.0, isFavorite: true, score: Game.Score.five, gameState: .playing, artworkImagesName: ["gow"], coverImageName: ""))
                .previewLayout(.fixed(width: 230, height: 180))
                .preferredColorScheme(.dark)
        }
    }
}
