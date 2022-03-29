//
//  GameDetail.swift
//  ToGaming
//
//  Created by felipe azevedo on 14/03/22.
//

import SwiftUI

struct GameDetail: View {
    
    @Environment(\.openURL) var openURL
    
    @Binding var game: Game
    @State var editing: EditMode = .inactive
    @State var testing: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if editing == .inactive {
                // TODO: Add Carrousel for array of images in games
                game.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    HStack(alignment: .top) {
                        game.coverImage
                            .resizable()
                            .frame(width: 112.5, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Action, Adventure")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Added")
                                    Text(DateHelper.toString(game.insertDate))
                                }
                                
                                HStack {
                                    Text("Launched")
                                    Text(DateHelper.toString(game.releaseDate))
                                }
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        .padding(.top, 50)
                        .padding(.bottom, 8)
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .strokeBorder(Color.green, antialiased: true)
                                .frame(width: 50, height: 50)
                                .shadow(radius: 4)
                                
                            VStack {
                                Text(String(format: "%.1f", game.rating))
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    
                                Text("Rating")
                                    .font(.caption2)
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding(.top, 50)
                    }
                    .padding(.top, -40)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(game.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: game.isFavorite ? "star.fill" : "star")
                                .font(.title2)
                                .foregroundColor(game.isFavorite ? .yellow : .secondary)
                        }
                        
                        HStack {
                            Text(game.platform)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            HStack {
                                Text(game.gameState?.rawValue ?? "")
                                    .bold()
                                Image(systemName: StatusToIcon.name(game.gameState))
                                    .accessibilityLabel(game.gameState?.rawValue ?? "Undefined State")
                                    .foregroundColor(.accentColor)
                            }
                            .font(.headline)
                        }
                        
                        HStack {
                            Text("SIE Santa Monica Studios")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            HStack {
                                Text(String(format: "%.1f", game.score ?? 0))
                                    .font(.headline)
                                    .bold()
                                Text("Score")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                        .padding(.top, 10)
                    
                    HStack {
                        Text("Summary")
                            .font(.title2)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    Text(game.summary)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    if let storyline = game.storyline {
                        HStack {
                            Text("Storyline")
                                .font(.title2)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        Text(storyline)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    if let url = game.igdbReference {
                        VStack {
                            Button("View More on IGDB") {
                                openURL(url)
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                        .padding(.vertical, 30)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            if editing == .active {
                EditGame()
            }
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .environment(\.editMode, $editing)
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetail(game: .constant(ModelData().games[0]))
        }
    }
}
