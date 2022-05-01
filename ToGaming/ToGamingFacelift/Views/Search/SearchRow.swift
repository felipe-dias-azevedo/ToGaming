//
//  SearchRow.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 01/05/22.
//

import SwiftUI

struct SearchRow: View {
    var body: some View {
        HStack {
            SearchRowContent()
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SearchRow()
        }
        .listStyle(.grouped)
        .preferredColorScheme(.dark)
    }
}
