//
//  SearchGameNewDetail.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/04/22.
//

import SwiftUI

struct SearchGameNewDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    
    let service = IgdbService()
    
    var igdbGameId: Int
    @State private var game: GameSearchCore? = nil
    
    @State private var index = 0
    @State private var addingGame = false
    
    @State private var showAlert = false
    @State private var showError = false
    @State private var isLoading = true
    
    func loadGame() {
        isLoading = true
        service.config()
        service.getGameById(id: igdbGameId) { gameData in
            if let data = gameData {
                let gameCore = GameSearchCore(context: viewContext)
                gameCore.id = UUID()
                gameCore.igdbReference = URL(string: data.url)
                gameCore.releaseDate = DateHelper.toDate(from: data.firstReleaseDate)
                gameCore.coverImageName = data.cover?.url
                gameCore.developer = data.involvedCompanies
                    .first(where: { $0.developer })
                    .map({ $0.company.name })
                gameCore.name = data.name
                gameCore.publisher = data.involvedCompanies
                    .first(where: { $0.publisher })
                    .map({ $0.company.name })
                gameCore.storyline = data.storyline
                gameCore.summary = data.summary
                gameCore.rating = data.aggregatedRating ?? 0
                gameCore.ratingCount = Double(data.aggregatedRatingCount ?? 0)
                gameCore.igdbId = Int32(data.id)
                gameCore.platforms = data.platforms.map({ $0.name })
                gameCore.genres = data.genres.map({ $0.name }) + data.themes.map({ $0.name })
                gameCore.artworkImagesName = data.screenshots.map({ $0.url })
                do {
                    try viewContext.save()
                    game = gameCore
                } catch {
                    showError = true
                }
            } else {
                showAlert = true
            }
            isLoading = false
        }
    }
    
    var body: some View {
        if !isLoading {
            if let game = game {
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
                .alert("Fetching Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Confirm your Client ID and Secret Key on Configuration Tab")
                }
                .alert("Data Error", isPresented: $showError) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                } message: {
                    Text("The app had a internal problem")
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
            }
        } else {
            ProgressView()
                .onAppear {
                    loadGame()
                }
        }
    }
}

struct SearchGameNewDetail_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameNewDetail(igdbGameId: 19560)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.light)
    }
}
