//
//  ToListGameCard.swift
//  ToGaming
//
//  Created by felipe azevedo on 22/03/22.
//

import SwiftUI

struct ToListGameCard: View {
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.gray)
                    .frame(width: 195.55, height: 110)
                    
                Image(systemName: "list.bullet")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            
            Text("View all in List")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 5)

    }
}

struct ToListGameCard_Previews: PreviewProvider {
    static var previews: some View {
        ToListGameCard()
            .previewLayout(.fixed(width: 230, height: 180))
            .preferredColorScheme(.light)
        
        ToListGameCard()
            .previewLayout(.fixed(width: 230, height: 180))
            .preferredColorScheme(.dark)
    }
}
