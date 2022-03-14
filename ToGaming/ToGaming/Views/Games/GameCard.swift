//
//  GameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct GameCard: View {
    var body: some View {
        HStack {
            Image("GodofWar")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 6)
            
            Spacer()
            
            VStack {
                Text("God of War")
                    .font(.title2)
                
                Text("Playstation 4")
                    .font(.subheadline)
            }
            .offset(x: -35)
            
        }
        .padding()
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                    .stroke(.gray, lineWidth: 5))
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCard()
    }
}
