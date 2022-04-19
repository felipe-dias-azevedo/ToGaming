//
//  SearchGameDetail.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import SwiftUI

struct SearchGameDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.openURL) private var openURL
    
    var game: FetchedResults<GameSearchCore>.Element
    var isRecentSearched: Bool
    @State private var index = 0
    @State private var addingGame = false
    
    var body: some View {
        ZStack {
            // TODO: When requesting data show ProgressView (loader)
            ScrollView(.vertical, showsIndicators: false) {
                TabView(selection: $index) {
                    ForEach((0..<game.artworkImagesName!.count), id: \.self) { index in
                        Image(game.artworkImagesName![index])
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(height: 220)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .aspectRatio(contentMode: .fill)
                
            LazyVStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(game.name!)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    HStack {
                        Text(game.developer!)
                            .fontWeight(.medium)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(game.publisher!)
                            .fontWeight(.heavy)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                .padding(.bottom, 12)
                
                HStack {
                    Image(game.coverImageName!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 112.5, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 20) {
                        
                        HStack {
                            Spacer()
                            Rating(score: game.rating)
                            Spacer()
                            VStack {
                                Text("Rating Count:")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                Text(String(format: "%.0f", game.ratingCount))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .bold()
                            }
                            Spacer()
                        }
                        
                        
                        if let url = game.igdbReference {
                            Button {
                                openURL(url)
                            } label: {
                                Text("View More on IGDB")
                                    .fontWeight(.regular)
                                Label("Arrow Icon", systemImage: "arrow.right")
                                    .labelStyle(.iconOnly)
                            }
                            .font(.footnote)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.leading, 10)
                }
                
                
                ScrollItems(title: "Genres:", items: game.genres!)
                    .padding(.vertical, 6)
                
                ScrollItems(title: "Platforms:", subtitle: "Total: \(game.platforms!.count)", items: game.platforms!)
                    .padding(.vertical, 6)
                
                HStack {
                    Text("Released in:")
                        .fontWeight(.light)
                        .font(.callout)
                    Spacer()
                    Text(DateHelper.toString(game.releaseDate!))
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                .padding(.top, 8)
                
                VStack {
                    Divider()
                        .padding(.vertical, 10)
                        .padding(.top, 10)

                    HStack {
                        Text("Summary")
                            .fontWeight(.medium)
                            .font(.title2)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 10)

                    Text(game.summary!)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .foregroundColor(.primary)

                    if let storyline = game.storyline {
                        Divider()
                            .padding(.vertical, 10)
                        
                        HStack {
                            Text("Storyline")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .font(.title2)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        // TODO: Show in a summarized way value with button to read everything
                        Text(storyline)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        addingGame.toggle()
                    } label: {
                        Text("Get Game")
                            .fontWeight(.bold)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial)
                .shadow(radius: 4)
            }
            .shadow(radius: 8)
        }
        .navigationBarTitle(game.name!)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    addingGame.toggle()
                } label: {
                    Label("Get Game", systemImage: "plus.circle")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .sheet(isPresented: $addingGame) {
            SearchGameAdd(game: game, adding: $addingGame)
        }
        .onAppear(perform: {
            // TODO: load data from IGDB
//            if !isRecentSearched && modelData.recentlySearched.first(where: { $0.igdbId == game.igdbId }) == nil {
//                    modelData.recentlySearched.append(game)
//                }
            })
    }
}

struct SearchGameDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchGameDetail(game: GameSearchCore.example, isRecentSearched: false)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
