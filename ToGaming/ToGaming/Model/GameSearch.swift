//
//  GameSearch.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation

struct GameSearch: Hashable, Codable, Identifiable {
    
    var id: UUID
    var name: String
    var releaseDate: Date
    var platform: String
}
