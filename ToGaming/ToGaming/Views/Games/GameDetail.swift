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
    @State var editing = false
    @State private var index = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TabView(selection: $index) {
                ForEach((0..<game.artworkImagesName.count), id: \.self) { index in
                    Image(game.artworkImagesName[index])
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(height: 220)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .aspectRatio(contentMode: .fill)
            
            LazyVStack {
                HStack(alignment: .top) {
                    Image(game.coverImageName)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 112.5, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(game.developer)
                                .fontWeight(.medium)
                                .font(.footnote)
                                .foregroundColor(.primary)
                            
                            Text(game.publisher)
                                .fontWeight(.light)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 10) {
                            Rating(score: game.rating)
                            
                            VStack {
                                Text("Rating Count:")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                Text(String(format: "%.0f", game.ratingCount))
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .bold()
                            }
                        }
                    }
                    .padding(.top, 45)
                    .padding(.bottom, 8)
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.top, -40)
                .padding(.bottom, 10)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(game.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button {
                            game.isFavorite.toggle()
                        } label: {
                            Label("Toggle Favorite", systemImage: game.isFavorite ? "heart.fill" : "heart")
                                .labelStyle(.iconOnly)
                                .font(.title2)
                                .foregroundColor(game.isFavorite ? .red : .secondary)
                        }
                    }
                    
                    HStack {
                        HStack {
                            Text(game.gameState.rawValue)
                                .bold()
                            Image(systemName: StatusToIcon.name(game.gameState))
                                .accessibilityLabel(game.gameState.rawValue)
                                .foregroundColor(.accentColor)
                        }
                        .font(.headline)
                        
                        Spacer()
                        
                        Text(game.platforms[game.favoritePlatform])
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Added: \(DateHelper.toString(game.insertDate))")
                            .fontWeight(.light)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        if let score = game.score {
                            HStack {
                                Text(String(score.rawValue))
                                    .font(.headline)
                                    .bold()
                                Label("Score Star Icon", systemImage: "star.fill")
                                    .labelStyle(.iconOnly)
                                    .font(.subheadline)
                                    .foregroundColor(.yellow)
                            }
                        } else {
                            HStack {
                                Text("No Score")
                                    .font(.headline)
                                    .bold()
                                Label("Score Star Icon", systemImage: "star.fill")
                                    .labelStyle(.iconOnly)
                                    .font(.subheadline)
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                
                ScrollItems(title: "Genres:", items: game.genres)
                    .padding(.top, 10)
                
                HStack {
                    Text("Released in:")
                        .fontWeight(.light)
                        .font(.callout)
                    Spacer()
                    Text(DateHelper.toString(game.releaseDate))
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                .padding(.top, 10)
                
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
                
                // TODO: Show in a summarized way value with button to read everything
                Text(game.summary)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .foregroundColor(.primary)
                
                if let storyline = game.storyline {
                    Divider()
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Storyline")
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    // TODO: Show in a summarized way value with button to read everything
                    Text(storyline)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                if let url = game.igdbReference {
                    VStack {
                        Button {
                            openURL(url)
                        } label: {
                            Text("View More on IGDB")
                                .fontWeight(.regular)
                            Label("Arrow Icon", systemImage: "arrow.right")
                                .labelStyle(.iconOnly)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                    .padding(.top, 30)
                }
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $editing) {
            EditGame(editing: $editing, game: $game)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    editing.toggle()
                } label: {
                    Label("Edit", systemImage: "gearshape")
                }
            }
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetail(game: .constant(ModelData().games[0]))
                .preferredColorScheme(.dark)
        }
    }
}
