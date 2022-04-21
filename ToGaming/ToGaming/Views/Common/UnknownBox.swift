//
//  UnknownBox.swift
//  ToGaming
//
//  Created by felipe azevedo on 21/04/22.
//

import SwiftUI

struct UnknownBox<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
            
            Image(systemName: "questionmark")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}

struct UnknownBox_Previews: PreviewProvider {
    static var previews: some View {
        UnknownBox {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.secondary)
                .frame(width: 195.55, height: 110)
                .shadow(radius: 4)
        }
    }
}
