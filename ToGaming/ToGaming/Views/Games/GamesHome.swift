//
//  GamesHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GamesHome: View {
    var body: some View {
        NavigationView {
            List {
                GameRow()
                GameRow(isFavorite: false)
                GameRow()
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EditGame()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

struct GamesHome_Previews: PreviewProvider {
    static var previews: some View {
        GamesHome()
    }
}
