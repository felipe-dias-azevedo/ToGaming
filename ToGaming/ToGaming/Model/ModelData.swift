//
//  ModelData.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var userConfig = UserConfig(userName: "", clientId: "", secretKey: "")
    
    @Published var games: [Game] = [
        Game(id: UUID(), name: "God of War", platform: "Playstation 4", insertDate: Date.now, isFavorite: false, gameState: .playing, imageName: "tw"),
        Game(id: UUID(), name: "The Witcher 3", platform: "Playstation 4", insertDate: Date.now, isFavorite: false, gameState: .played, imageName: "tw"),
        Game(id: UUID(), name: "Gran Turismo 7", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, gameState: .toBuy, imageName: "tw"),
        Game(id: UUID(), name: "Lego Star Wars", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, gameState: .toPlay, imageName: "tw")
    ]
    
    @Published var recentlySearched: [GameSearch] = [
        GameSearch(id: UUID(), name: "The Last Of Us 2", insertDate: Date()),
        GameSearch(id: UUID(), name: "Gran Turismo 7", insertDate: Date(), game: Game(id: UUID(), name: "Gran Turismo 7", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, gameState: .toBuy, imageName: "tw")),
        GameSearch(id: UUID(), name: "Ghost of Tsushima", insertDate: Date.now),
    ]
}
