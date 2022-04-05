//
//  ListSelect.swift
//  ToGaming
//
//  Created by felipe azevedo on 04/04/22.
//

import SwiftUI

struct ListSelect: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var editMode = EditMode.active
    
    var title: String
    var items: [String]
    @Binding var itemSelection: String?
    @State private var oldItem: String? = nil
    
    
    var body: some View {
        NavigationView {
            List(items, id: \.self, selection: $itemSelection) { item in
                Text(item)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        itemSelection = oldItem
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
        .onAppear(perform: { if let selected = itemSelection { oldItem = selected } })
    }
}

struct ListSelect_Previews: PreviewProvider {
    static var previews: some View {
        ListSelect(title: "Games", items: ModelData().games.map({ $0.name }), itemSelection: .constant(nil))
    }
}
