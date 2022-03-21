//
//  Game.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import Foundation
import SwiftUI

struct Game: Hashable, Codable, Identifiable {
    
    var id: UUID
    var name: String
    var platform: String
    var insertDate: Date
    var isFavorite: Bool
    var score: Float?
    
    var gameState: GameStatus?
    enum GameStatus: String, CaseIterable, Codable {
        case playing = "Playing"
        case played = "Played"
        case toPlay = "To Play"
        case toBuy = "To Buy"
    }
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}
