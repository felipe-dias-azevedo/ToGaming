//
//  ContentView.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 30/04/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
