//
//  ScrollItems.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI


struct ScrollItems: View {
    
    var title: String
    var subtitle: String?
    var items: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                if let subtitle = subtitle {
                    Text(subtitle)
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(red: 0.94, green: 0.94, blue: 0.94))
                            Text(item)
                                .fontWeight(.regular)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollItems_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollItems(title: "Platforms", subtitle: "3", items: ["Playstation 4", "Xbox One", "PC"])
            
            ScrollItems(title: "Genres", items: ["Action", "Adventure", "Stealth", "Racing"])
        }
        .previewLayout(.fixed(width: 360, height: 80))
    }
}
