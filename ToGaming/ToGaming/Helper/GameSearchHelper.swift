//
//  GameSearchHelper.swift
//  ToGaming
//
//  Created by felipe azevedo on 10/04/22.
//

import Foundation
import CoreData

class GameSearchHelper {
    
    static func convert(_ game: GameSearch, _ context: NSManagedObjectContext) -> GameSearchCore {
        let gameCore = GameSearchCore(context: context)
        gameCore.id = game.id
        gameCore.igdbReference = game.igdbReference
        gameCore.releaseDate = game.releaseDate
        gameCore.coverImageName = game.coverImageName
        gameCore.developer = game.developer
        gameCore.name = game.name
        gameCore.publisher = game.publisher
        gameCore.storyline = game.storyline
        gameCore.summary = game.summary
        gameCore.rating = game.rating
        gameCore.ratingCount = game.ratingCount
        gameCore.igdbId = game.igdbId
        gameCore.platforms = game.platforms
        gameCore.genres = game.genres
        gameCore.artworkImagesName = game.artworkImagesName
        return gameCore
    }
    
    static func convert(_ gameCore: GameSearchCore) -> GameSearch {
        return GameSearch(
            id: gameCore.id!,
            igdbId: gameCore.igdbId,
            name: gameCore.name!,
            genres: gameCore.genres!,
            platforms: gameCore.platforms!,
            publisher: gameCore.publisher!,
            developer: gameCore.developer!,
            releaseDate: gameCore.releaseDate!,
            summary: gameCore.summary!,
            rating: gameCore.rating,
            ratingCount: gameCore.ratingCount,
            artworkImagesName: gameCore.artworkImagesName!,
            coverImageName: gameCore.coverImageName!)
    }
}
