//
//  FormField.swift
//  ToGaming
//
//  Created by felipe azevedo on 24/03/22.
//

import SwiftUI

struct FormField: View {
    
    var title: String
    var placeholder: String?
    @Binding var textField: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(title)
            
            TextField(placeholder ?? title, text: $textField)
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                FormField(title: "Example", textField: .constant(String()))
            }            
        }
    }
}
