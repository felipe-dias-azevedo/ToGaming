//
//  FilterSection.swift
//  ToGaming
//
//  Created by felipe azevedo on 04/04/22.
//

import SwiftUI

struct FilterSection: View {
    
    var title: String
    @Binding var selectedItem: String?
    @Binding var toggle: Bool
    
    var body: some View {
        Section {
            HStack {
                Text(title)
                    .fontWeight(.light)
                    .font(.body)
             
                Spacer()
                
                Button {
                    withAnimation {
                        toggle.toggle()
                    }
                } label: {
                    Label("Open Sheet", systemImage: "list.bullet")
                        .font(.body)
                        .labelStyle(.iconOnly)
                        .foregroundColor(.primary)
                }
            }
            
            if let item = selectedItem {
                HStack {
                    Text(item)
                        .font(.body)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            selectedItem = nil
                        }
                    } label: {
                        Label("Unselect Selected Item", systemImage: "xmark.circle.fill")
                            .font(.body)
                            .labelStyle(.iconOnly)
                    }
                }
            }
        }
    }
}

struct FilterSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FilterSection(title: "Platform", selectedItem: .constant("Playstation 4"), toggle: .constant(false))
            
            FilterSection(title: "Genre", selectedItem: .constant(nil), toggle: .constant(false))
        }
    }
}
