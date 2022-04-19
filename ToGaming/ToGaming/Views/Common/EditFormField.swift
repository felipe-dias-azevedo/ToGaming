//
//  EditFormField.swift
//  ToGaming
//
//  Created by felipe azevedo on 05/04/22.
//

import SwiftUI

struct EditFormField<Content: View>: View {
    
    var title: String
    var textField: String
    var isEditing: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            Text(title)
                .font(.body)
                .fontWeight(.regular)
                .lineLimit(1)
            
            if isEditing {
                content
                    .multilineTextAlignment(.trailing)
            } else {
                Text(textField)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct EditFormField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                EditFormField(title: "Name", textField: "", isEditing: true) {
                    TextField("Name", text: .constant(""))
                }
                EditFormField(title: "Client ID", textField: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", isEditing: true) {
                    TextField("Name", text: .constant("AAAAAAAAAAAAAAAAAAA"))
                }
                EditFormField(title: "Secret Key", textField: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", isEditing: false) {
                    TextField("Name", text: .constant("AAAAAAAAAAAAAAAAAAA"))
                }
                EditFormField(title: "Platform", textField: "Playstation 4", isEditing: false) {
                    TextField("Platform", text: .constant("Playstation 4"))
                }
                EditFormField(title: "Extra", textField: "", isEditing: false) {
                    TextField("Extra", text: .constant(""))
                }
            }
        }
    }
}
