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
        AsyncImage(url: url, scale: 1) { phase in
            if let image = phase.image {
                switch type {
                case .artwork:
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .cover:
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 112.5, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                case .card:
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 195.55, height: 110)
                        .cornerRadius(10)
                case .row:
                    image
                        .resizable()
                        .frame(width: 88.88, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                case .recentRow:
                    image
                        .resizable()
                        .frame(width: 56.25, height: 75)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                }
            } else if phase.error != nil {
                switch type {
                case .artwork:
                    UnknownBox {
                        Rectangle()
                            .fill(.gray)
                            .aspectRatio(contentMode: .fill)
                    }
                case .cover:
                    UnknownBox {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray)
                            .frame(width: 112.5, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 4)
                    }
                case .card:
                    UnknownBox {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray)
                            .frame(width: 195.55, height: 110)
                    }
                case .row:
                    UnknownBox {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray)
                            .frame(width: 88.88, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                case .recentRow:
                    UnknownBox {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.gray)
                            .frame(width: 56.25, height: 75)
                            .aspectRatio(contentMode: .fit)
                    }
                }
            } else {
                switch type {
                case .artwork:
                    ProgressView()
                case .cover:
                    ProgressView()
                        .frame(width: 112.5, height: 150)
                case .card:
                    ProgressView()
                        .frame(width: 195.55, height: 110)
                case .row:
                    ProgressView()
                        .frame(width: 88.88, height: 50)
                case .recentRow:
                    ProgressView()
                        .frame(width: 56.25, height: 75)
                }
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RemoteImage(url: ImageHelper.toURL("https://images.igdb.com/igdb/image/upload/t_720p/co1tmu.jpg"), type: .artwork)
            
            RemoteImage(url: ImageHelper.toURL("https://images.igdb.com/igdb/image/upload/t_720p/co1tmu.jpg"), type: .cover)
            
            RemoteImage(url: ImageHelper.toURL("https://images.igdb.com/igdb/image/upload/t_720p/co1tmu.jpg"), type: .card)
        }
    }
}
