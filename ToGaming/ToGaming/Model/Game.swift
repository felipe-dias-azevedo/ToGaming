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
    var igdbId: Int
    var name: String
    // TODO: Platform of Class and have its platforms stored in ModelData
    var platform: String
    // TODO: Include game genres, enum
    // involved_companies.company.name
    var publisher: String
    var insertDate: Date
    var releaseDate: Date
    var summary: String
    var storyline: String?
    // rating from IGDB: aggregated_rating
    var rating: Double
    // rating count from IGDB: aggregated_rating_count
    var ratingCount: Double
    var igdbReference: URL?
    var isFavorite: Bool
    // users defined own rating
    var score: Float?
    
    // TODO: Virtual State for GameStatus -> When started toBuy, when toPlay, etc.
    // If Date of next attribute is nil, then its the previous state
    
    var gameState: Status?
    enum Status: String, CaseIterable, Codable {
        case playing = "Playing"
        case played = "Played"
        case toPlay = "To Play"
        case toBuy = "To Buy"
    }
    
    // TODO: array of images (max 3: first, second and last)
    var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var coverImageName: String
    var coverImage: Image {
        Image(coverImageName)
    }
    
    static let new = Game(id: UUID(), igdbId: 0, name: "", platform: "", publisher: "", insertDate: Date(), releaseDate: Date(), summary: "", rating: 0.0, ratingCount: 0, isFavorite: false, imageName: "", coverImageName: "")
}
