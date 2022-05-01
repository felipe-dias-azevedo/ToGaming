//
//  ToGamingFaceliftApp.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 30/04/22.
//

import SwiftUI

@main
struct ToGamingFaceliftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
