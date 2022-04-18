//
//  GameRecentlySearched.swift
//  ToGaming
//
//  Created by felipe azevedo on 17/04/22.
//

import Foundation

struct GameNewSearch: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let rating: Double?
    let releaseDate: Date?
    let platforms: [String]
    let developer: String?
}
