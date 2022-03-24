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
    // TODO: Platform of Class and have its platforms stored in ModelData
    var platform: String
    var insertDate: Date
    var isFavorite: Bool
    var score: Float?
    
    // TODO: Virtual State for GameStatus -> When started toBuy, when toPlay, etc.
    // If Date of next attribute is nil, then its the previous state
    
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
    
    static let new = Game(id: UUID(), name: "", platform: "", insertDate: Date(), isFavorite: false, imageName: "")
}
