//
//  GameHelper.swift
//  ToGaming
//
//  Created by felipe azevedo on 10/04/22.
//

import Foundation
import CoreData

class GameHelper {
    
    static func convert(_ game: Game, _ context: NSManagedObjectContext) -> GameCore {
        let gameCore = GameCore(context: context)
        gameCore.id = game.id
        gameCore.igdbReference = game.igdbReference
        gameCore.releaseDate = game.releaseDate
        gameCore.insertDate = game.insertDate
        gameCore.updateDate = game.updateDate
        gameCore.isFavorite = game.isFavorite
        gameCore.coverImageName = game.coverImageName
        gameCore.developer = game.developer
        gameCore.gameState = game.gameState.rawValue
        gameCore.name = game.name
        gameCore.publisher = game.publisher
        gameCore.storyline = game.storyline
        gameCore.summary = game.summary
        gameCore.rating = game.rating
        gameCore.ratingCount = game.ratingCount
        gameCore.igdbId = game.igdbId
        gameCore.favoritePlatform = game.favoritePlatform
        gameCore.score = game.score?.rawValue ?? 0
        gameCore.platforms = game.platforms
        gameCore.genres = game.genres
        gameCore.artworkImagesName = game.artworkImagesName
        return gameCore
    }
    
    static func convert(_ gameCore: GameCore) -> Game {
        return Game(
            id: gameCore.id!,
            igdbId: gameCore.igdbId,
            name: gameCore.name!,
            platforms: gameCore.platforms!,
            favoritePlatform: gameCore.favoritePlatform,
            genres: gameCore.genres!,
            publisher: gameCore.publisher!,
            developer: gameCore.developer!,
            insertDate: gameCore.insertDate!,
            releaseDate: gameCore.releaseDate!,
            summary: gameCore.summary!,
            storyline: gameCore.storyline,
            rating: gameCore.rating,
            ratingCount: gameCore.ratingCount,
            igdbReference: gameCore.igdbReference,
            isFavorite: gameCore.isFavorite,
            score: Game.Score.init(rawValue: gameCore.score),
            gameState: Game.Status.init(rawValue: gameCore.gameState!)!,
            artworkImagesName: gameCore.artworkImagesName!,
            coverImageName: gameCore.coverImageName!,
            updateDate: gameCore.updateDate!)
    }
}
