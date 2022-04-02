//
//  KeyValueText.swift
//  ToGaming
//
//  Created by felipe azevedo on 02/04/22.
//

import SwiftUI

struct KeyValueText: View {
    
    var key: String
    var value: String
    var spacing: CGFloat = 10
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            Text(key)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.primary)
        }
    }
}

struct KeyValueText_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueText(key: "Name", value: "God of War")
    }
}
