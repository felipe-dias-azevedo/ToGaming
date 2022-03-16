//
//  ConfigHome.swift
//  ToGaming
//
//  Created by felipe azevedo on 13/03/22.
//

import SwiftUI

struct ConfigHome: View {
    @FocusState private var isFocused: Bool
    @State var texto: String
    
    var body: some View {
        List {
            HStack {
                Text("User Name")
                
                TextField("commida boa", text: $texto)
                    .focused($isFocused)
            }
        }
    }
}

struct ConfigHome_Previews: PreviewProvider {
    static var previews: some View {
        ConfigHome(texto: "felipe")
    }
}
