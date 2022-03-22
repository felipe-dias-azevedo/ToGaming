//
//  EmptyGameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 22/03/22.
//

import SwiftUI

struct EmptyGameCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.gray)
                    .frame(width: 195.55, height: 155)
                    
                Image(systemName: "questionmark")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 5)
    }
}

struct EmptyGameCard_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGameCard()
            .previewLayout(.fixed(width: 230, height: 180))
            .preferredColorScheme(.light)
        
        EmptyGameCard()
            .previewLayout(.fixed(width: 230, height: 180))
            .preferredColorScheme(.dark)
    }
}
