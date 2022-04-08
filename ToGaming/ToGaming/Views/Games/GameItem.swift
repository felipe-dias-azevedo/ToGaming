//
//  GameItem.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct GameItem: View {
    
    var title: String
    var games: Array<Binding<Game>>
    
    var body: some View {
        if (!games.isEmpty) {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title3)
                        .bold()
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    NavigationLink {
                        GamesList(titleList: title, games: games)
                    } label: {
                        Text("See it all")
                            .foregroundColor(.blue)
                            .padding(.trailing, 15)
                            .padding(.top, 5)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 0) {
                        ForEach(games) { $game in
                            NavigationLink {
                                GameDetail(game: $game)
                            } label: {
                                GameCard(game: game)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 160)
            }
            .padding(.vertical, 10)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }
}

struct GameItem_Previews: PreviewProvider {
    
    static let games = ModelData().games
    
    static var previews: some View {
        GameItem(title: "All Games", games: games.map { .constant($0) })
            .previewLayout(.fixed(width: 360, height: 250))
        
        GameItem(title: "New Games", games: games.map { .constant($0) })
            .previewLayout(.fixed(width: 360, height: 250))
            .preferredColorScheme(.dark)
        
        GameItem(title: "New Games", games: Array())
            .previewLayout(.fixed(width: 360, height: 250))
            .preferredColorScheme(.dark)
    }
}
