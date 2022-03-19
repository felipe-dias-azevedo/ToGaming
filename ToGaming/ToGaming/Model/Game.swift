//
//  Game.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import Foundation
import SwiftUI

struct Game: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var platform: String
    var insertDate: Date
    var isFavorite: Bool
    
    // TODO: Score point for game
    
    // TODO: State of the game
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}
