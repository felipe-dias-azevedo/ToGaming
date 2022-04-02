//
//  GameSearch.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation
import SwiftUI

struct GameSearch: Hashable, Codable, Identifiable {
    
    var id: UUID
    var igdbId: Int?
    var name: String
    var genres: [String]
    var platforms: [String]
    var publisher: String
    var developer: String
    var releaseDate: Date
    var summary: String
    var storyline: String?
    // rating from IGDB: aggregated_rating
    var rating: Double
    // rating count from IGDB: aggregated_rating_count
    var ratingCount: Double
    var igdbReference: URL?
    var artworkImagesName: [String]
    var coverImageName: String
}
