//
//  ConfigFieldRow.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 01/05/22.
//

import SwiftUI

struct ConfigFieldRow: View {
    
    @Binding var value: String
    let placeholder: String
    let icon: IconSymbol
    let isEditing: Bool
    
    var body: some View {
        HStack {
            Label(placeholder, systemImage: "\(icon.rawValue)\(isEditing ? "" : ".fill")")
                .labelStyle(.iconOnly)
                .foregroundColor(.secondary)
            if isEditing {
                TextField(placeholder, text: $value)
            } else if value.isEmpty {
                Text(placeholder)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            } else {
                Text(value)
                    .fontWeight(.medium)
                    .lineLimit(1)
            }
        }
    }
}

struct ConfigFieldRow_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ConfigFieldRow(value: .constant(""), placeholder: "Name", icon: IconSymbol.star, isEditing: true)
            
            ConfigFieldRow(value: .constant("Name Example"), placeholder: "Name", icon: IconSymbol.star, isEditing: true)
            
            ConfigFieldRow(value: .constant("Name Example"), placeholder: "Name", icon: IconSymbol.star, isEditing: false)
            
            ConfigFieldRow(value: .constant(""), placeholder: "Name", icon: IconSymbol.star, isEditing: false)
        }
        .preferredColorScheme(.dark)
    }
}
