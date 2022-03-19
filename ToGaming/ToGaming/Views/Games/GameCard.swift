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
        // TODO: Beautiful game card with data from the game (image, name, platform, score, date started)
        Text(game.name)
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCard(game: .constant(ModelData().games[0]))
    }
}
