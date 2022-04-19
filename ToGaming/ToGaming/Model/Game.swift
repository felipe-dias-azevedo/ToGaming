//
//  Game.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import Foundation

struct Game: Hashable, Codable, Identifiable {
    
    var id: UUID
    var igdbId: Int32
    var name: String
    var platforms: [String]
    var favoritePlatform: Int16
    var genres: [String]
    // involved_companies.company.name
    var publisher: String
    var developer: String
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
    var score: Score?
    enum Score: Int16, CaseIterable, Codable, Identifiable {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        
        var id: Int16 { rawValue }
    }
    
    var gameState: Status
    enum Status: String, CaseIterable, Codable, Identifiable {
        case playing = "Playing"
        case played = "Played"
        case toPlay = "To Play"
        case toBuy = "To Buy"
        
        var id: String { rawValue }
    }
    
    var artworkImagesName: [String]
    var coverImageName: String
    
    var updateDate: Date
    
    static let new = Game(id: UUID(), igdbId: 0, name: "", platforms: [], favoritePlatform: 0, genres: [], publisher: "", developer: "", insertDate: Date(), releaseDate: Date(), summary: "", rating: 0.0, ratingCount: 0, isFavorite: false, gameState: .toBuy, artworkImagesName: [], coverImageName: "", updateDate: Date())
}
