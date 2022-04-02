//
//  SearchGameDetail.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import SwiftUI

struct SearchGameDetail: View {
    
    @Binding var game: GameSearch
    @State private var index = 0
    @State private var addingGame = false
    
    var body: some View {
        ZStack {
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
                VStack {
                    HStack {
                        Text(game.name)
                            .font(.largeTitle)
                     
                        Spacer()
                    }
                    HStack {
                        Text(game.platforms.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                
                Section {
                    HStack {
                        Text("Released in:")
                            .font(.headline)
                        Spacer()
                        Text(DateHelper.toString(game.releaseDate))
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Genres:")
                            .font(.headline)
                        Spacer()
                        Text(game.genres.joined(separator: ", "))
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Rating:")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.0f%%", game.rating))
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Rating Count:")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.0f", game.ratingCount))
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Publisher:")
                            .font(.headline)
                        Spacer()
                        Text(game.publisher)
                            .font(.subheadline)
                    }
                }
                
                Image(game.coverImageName)
                    .resizable()
                    .frame(width: 112.5, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                
                VStack {
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
                        .font(.body)

                }
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
            }
            VStack {
                Spacer()
                HStack {
                    Button("Get Game") {
                        addingGame.toggle()
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial)
                .shadow(radius: 4)
            }
            .shadow(radius: 8)
        }
        .navigationBarTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    addingGame.toggle()
                } label: {
                    Label("Get Game", systemImage: "plus.square.on.square")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .sheet(isPresented: $addingGame) {
            SearchGameAdd(game: game)
        }
    }
}

struct SearchGameDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchGameDetail(game: .constant(ModelData().recentlySearched[0]))
                .preferredColorScheme(.dark)
        }
    }
}
