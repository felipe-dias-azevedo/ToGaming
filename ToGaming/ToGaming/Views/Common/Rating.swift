//
//  Rating.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI

struct Rating: View {
    
    var score: Double
    
    private var ratingColor: Color {
        switch score {
        case 70...100:
            return .green
        case 40..<70:
            return .yellow
        case 1..<40:
            return .red
        default:
            return .gray
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(ratingColor, lineWidth: 3, antialiased: true)
                .frame(width: 50, height: 50)
                
            VStack {
                Text(String(format: "%.0f%%", score))
                    .font(.caption)
                    .bold()
                    .foregroundColor(.primary)
                    
                Text("Rating")
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Rating(score: 100)
            Rating(score: 96.56)
            Rating(score: 70)
            Rating(score: 69)
            Rating(score: 40)
            Rating(score: 39)
            Rating(score: 1)
            Rating(score: 0)
        }
        .previewLayout(.fixed(width: 50, height: 50))
    }
}
