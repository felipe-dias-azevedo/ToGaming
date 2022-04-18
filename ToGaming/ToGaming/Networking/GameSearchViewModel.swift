//
//  GameSearchViewModel.swift
//  ToGaming
//
//  Created by felipe azevedo on 17/04/22.
//

import Foundation

struct GameSearchViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let aggregatedRating: Double?
    let cover: CoverGameSearchViewModel?
    let firstReleaseDate: Int?
    let name: String
    let platforms: [PlatformGameSearchViewModel]
    let involvedCompanies: [InvolvedCompanyGameSearchViewModel]
}

struct CoverGameSearchViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let url: String
}

struct PlatformGameSearchViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct InvolvedCompanyGameSearchViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let company: CompanyGameSearchViewModel
    let developer: Bool
}

struct CompanyGameSearchViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}
