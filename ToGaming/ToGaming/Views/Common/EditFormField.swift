//
//  EditFormField.swift
//  ToGaming
//
//  Created by felipe azevedo on 05/04/22.
//

import SwiftUI

struct EditFormField: View {
    
    var title: String
    var placeholder: String?
    @Binding var textField: String
    var isEditing: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(.body)
                .fontWeight(.regular)
            
            if isEditing {
                TextField(placeholder ?? title, text: $textField)
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
                EditFormField(title: "Name", textField: .constant(String()), isEditing: true)
                
                EditFormField(title: "Object", textField: .constant("value"), isEditing: false)
            }
        }
    }
}
