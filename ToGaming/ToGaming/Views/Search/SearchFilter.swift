//
//  SearchFilter.swift
//  ToGaming
//
//  Created by felipe azevedo on 01/04/22.
//

import SwiftUI

struct SearchFilter: View {
    var body: some View {
        NavigationView {
            Form {
                // TODO: Filter menu game of platform, genre, publisher, developer, releaseDate etc
                Text("Search Filter")
            }
        }
        
    }
}

struct SearchFilter_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilter()
    }
}
