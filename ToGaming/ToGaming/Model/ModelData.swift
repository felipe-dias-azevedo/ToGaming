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
        Game(id: 1, name: "God of War", platform: "Playstation 4", insertDate: Date.now, isFavorite: false, imageName: "tw"),
        Game(id: 2, name: "The Witcher 3", platform: "Playstation 4", insertDate: Date.now, isFavorite: false, imageName: "tw"),
        Game(id: 3, name: "Gran Turismo 7", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, imageName: "tw"),
        Game(id: 4, name: "Lego Star Wars", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, imageName: "tw")
    ]
    
    @Published var recentlySearched: [GameSearch] = [
        GameSearch(id: 1, name: "The Last Of Us 2", insertDate: Date()),
        GameSearch(id: 2, name: "Gran Turismo 7", insertDate: Date(), game: Game(id: 3, name: "Gran Turismo 7", platform: "Playstation 4", insertDate: Date.now, isFavorite: true, imageName: "tw")),
        GameSearch(id: 3, name: "Ghost of Tsushima", insertDate: Date.now),
    ]
}
