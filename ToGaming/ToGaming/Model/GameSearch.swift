//
//  GameSearch.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation

struct GameSearch: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var insertDate: Date
    var game: Game?
}
