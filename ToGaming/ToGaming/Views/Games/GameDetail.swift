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
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(height: 220)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .aspectRatio(contentMode: .fill)
            
            VStack {
                HStack(alignment: .top) {
                    Image(game.coverImageName)
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
                                Text("Added:")
                                Text(DateHelper.toString(game.insertDate))
                            }
                            
                            HStack {
                                Text("Launched:")
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
                        // TODO: Change color based on rating value (green >70%, yellow >40%, red 1<=39%, grey 0%)
                            .strokeBorder(.green, lineWidth: 3, antialiased: true)
                            .frame(width: 50, height: 50)
                            
                        VStack {
                            Text(String(format: "%.0f%%", game.rating))
                                .font(.caption)
                                .bold()
                                .foregroundColor(.primary)
                                
                            Text("Rating")
                                .font(.caption2)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.top, 50)
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
                        Text(game.platform)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text(game.gameState.rawValue)
                                .bold()
                            Image(systemName: StatusToIcon.name(game.gameState))
                                .accessibilityLabel(game.gameState.rawValue)
                                .foregroundColor(.accentColor)
                        }
                        .font(.headline)
                    }
                    
                    HStack {
                        Text(game.publisher)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text(String(game.score?.rawValue ?? 0))
                                .font(.headline)
                                .bold()
                            Label("Score Star Icon", systemImage: "star.fill")
                                .labelStyle(.iconOnly)
                                .font(.subheadline)
                                .foregroundColor(.primary)
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
                        Button("View More on IGDB") {
                            openURL(url)
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
        }
    }
}
