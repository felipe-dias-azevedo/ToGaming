//
//  GameItem.swift
//  ToGaming
//
//  Created by felipe azevedo on 20/03/22.
//

import SwiftUI

struct GameItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var title: String
    let games: [FetchedResults<GameCore>.Element]
    
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
                        ForEach(games, id: \.self) { game in
                            NavigationLink {
                                GameDetail(game: game)
                            } label: {
                                GameCard(game: game)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 160)
            }
            .onAppear {
                viewContext.refreshAllObjects()
            }
            .padding(.vertical, 10)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }
}

struct GameItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameItem(title: "All Games", games: GameCore.examples)
            
            GameItem(title: "New Games", games: GameCore.examples)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 360, height: 250))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
