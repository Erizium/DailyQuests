//
//  Daily_QuestsApp.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import Firebase

@main
struct Daily_QuestsApp: App {
    let persistenceController = PersistenceController.shared
    
    init()  {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
