//
//  GameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GameCard: View {
    
    @Binding var game: Game
    
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
                        .font(.headline)
                        .foregroundColor(.primary)
                        .bold()
                    
                    Spacer()
                    
                    if let score = game.score {
                        HStack(alignment: .center, spacing: 2) {
                            Text(String(score.rawValue))
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                HStack(alignment: .center) {
                    Text(game.platform)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(DateHelper.toString(game.insertDate))
                        .font(.caption)
                        .foregroundColor(.secondary)
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
        
        GameCard(game: .constant(ModelData().games[0]))
            .previewLayout(.fixed(width: 230, height: 180))
        
        GameCard(game: .constant(ModelData().games[1]))
            .previewLayout(.fixed(width: 230, height: 180))
            .preferredColorScheme(.dark)
    }
}
