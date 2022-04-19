//
//  GameSearchDataViewModel.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/04/22.
//

import Foundation

struct GameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let aggregatedRating: Double?
    let aggregatedRatingCount: Int?
    let cover: CoverGameSearchDataViewModel?
    let firstReleaseDate: Int?
    let genres: [GenreGameSearchDataViewModel]
    let involvedCompanies: [InvolvedCompanyGameSearchDataViewModel]
    let name: String
    let platforms: [PlatformGameSearchDataViewModel]
    let screenshots: [CoverGameSearchDataViewModel]
    let storyline: String?
    let summary: String?
    let themes: [GenreGameSearchDataViewModel]
    let url: String
}

struct CoverGameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let url: String
}

struct PlatformGameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct GenreGameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct CompanyGameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct InvolvedCompanyGameSearchDataViewModel: Hashable, Codable, Identifiable {
    let id: Int
    let company: CompanyGameSearchDataViewModel
    let developer: Bool
    let publisher: Bool
}
