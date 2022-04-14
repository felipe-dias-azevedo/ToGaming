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
        HStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(.body)
                .fontWeight(.regular)
            
            if isEditing {
                content
            } else {
                Spacer()
                
                Text(textField)
                    .font(.body)
                    .fontWeight(.medium)
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
            }
        }
    }
}
