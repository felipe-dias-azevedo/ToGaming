//
//  RemoteImage.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/04/22.
//

import SwiftUI

struct RemoteImage: View {
    
    enum TypeImage: Int {
        case artwork = 0
        case cover = 1
        case card = 2
        case row = 3
        case recentRow = 4
    }
    
    var url: URL?
    var type: TypeImage
    
    var body: some View {
        AsyncImage(url: url) { image in
            if type == .artwork {
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            if type == .cover {
                image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 112.5, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(radius: 4)
            }
            if type == .card {
                image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 195.55, height: 110)
                    .cornerRadius(10)
            }
            if type == .row {
                image
                    .resizable()
                    .frame(width: 88.88, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            if type == .recentRow {
                image
                    .resizable()
                    .frame(width: 56.25, height: 75)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
        } placeholder: {
            ProgressView()
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RemoteImage(url: ImageHelper.toURL("https://images.igdb.com/igdb/image/upload/t_720p/co1tmu.jpg"), type: .artwork)
            
            RemoteImage(url: ImageHelper.toURL("https://images.igdb.com/igdb/image/upload/t_720p/co1tmu.jpg"), type: .cover)
        }
    }
}
