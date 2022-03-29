//
//  ModelData.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var userConfig = UserConfig(userName: "", preferredPlatform: "", clientId: "", secretKey: "")
    
    @Published var games: [Game] = [
        Game(
            id: UUID(),
            igdbId: 1,
            name: "God of War",
            platform: "Playstation 4",
            insertDate: Date(timeIntervalSinceNow: -259200),
            releaseDate: Date(timeIntervalSince1970: 1541127600),
            summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            storyline: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            rating: 98.89,
            ratingCount: 130000,
            igdbReference: URL(string: "https://www.igdb.com/games/god-of-war--1"),
            isFavorite: false,
            score: 4.0,
            gameState: .playing,
            imageName: "gow",
            coverImageName: "cover_gow"),
        Game(
            id: UUID(),
            igdbId: 2,
            name: "The Witcher 3",
            platform: "Playstation 4",
            insertDate: Date(timeIntervalSinceNow: -86400),
            releaseDate: Date(timeIntervalSince1970: 1541127600),
            summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            rating: 99.77,
            ratingCount: 490000,
            isFavorite: false,
            gameState: .played,
            imageName: "tw",
            coverImageName: "cover_gow"),
        Game(
            id: UUID(),
            igdbId: 3,
            name: "Gran Turismo 7",
            platform: "Playstation 4",
            insertDate: Date(timeIntervalSinceNow: -1209600),
            releaseDate: Date(timeIntervalSince1970: 1637454576),
            summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            rating: 91.10,
            ratingCount: 20000,
            isFavorite: true,
            gameState: .toBuy,
            imageName: "gt",
            coverImageName: "cover_gow"),
        Game(
            id: UUID(),
            igdbId: 4,
            name: "Lego Star Wars",
            platform: "Playstation 4",
            insertDate: Date(timeIntervalSinceNow: -777600),
            releaseDate: Date(timeIntervalSince1970: 1654475566),
            summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            rating: 0,
            ratingCount: 0,
            igdbReference: URL(string: "https://www.igdb.com/games/lego-star-wars-the-skywalker-saga"),
            isFavorite: true,
            gameState: .toPlay,
            imageName: "legosw",
            coverImageName: "cover_legosw"),
        Game(
            id: UUID(),
            igdbId: 5,
            name: "Nun Massacre",
            platform: "PC",
            insertDate: Date(timeIntervalSinceNow: -172800),
            releaseDate: Date(timeIntervalSince1970: 1541127600),
            summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mi justo, sagittis id rhoncus id, sodales quis turpis. Vivamus convallis purus et enim dictum, non tristique ligula imperdiet. Praesent nec nisi ultricies, mollis ex in, sollicitudin tellus. Proin justo libero, pharetra ut risus sit amet, cursus pellentesque risus. Praesent gravida luctus elit semper eleifend. Morbi et imperdiet nisi. Fusce eu justo efficitur, aliquam lorem lacinia, mollis felis. Aenean dignissim, augue placerat dapibus rhoncus, neque enim efficitur metus, nec tristique nisi odio a orci. Ut egestas odio ut quam varius lacinia. Phasellus non lacinia urna. Curabitur diam odio, condimentum nec ipsum tincidunt, scelerisque congue enim. Sed gravida sem eu volutpat bibendum. Vivamus in ex id enim luctus luctus quis eget mi. Proin facilisis hendrerit ante ut blandit. Maecenas quis tellus enim. Nulla facilisis eros non vehicula aliquam.",
            rating: 63.33,
            ratingCount: 130,
            isFavorite: false,
            gameState: .toBuy,
            imageName: "nm",
            coverImageName: "cover_gow")
    ]
    
    @Published var recentlySearched: [GameSearch] = [
        GameSearch(id: UUID(), name: "The Last Of Us 2", releaseDate: Date(timeIntervalSince1970: 1558666800), platform: "Playstation 4"),
        GameSearch(id: UUID(), name: "Gran Turismo 7", releaseDate: Date(timeIntervalSince1970: 1637454576), platform: "Playstation 4"),
        GameSearch(id: UUID(), name: "Ghost of Tsushima", releaseDate: Date(timeIntervalSince1970: 1574046000), platform: "Playstation 4"),
    ]
}
