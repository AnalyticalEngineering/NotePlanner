//
//  NotePlannerApp.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/12/24.
//

import SwiftUI
import SwiftData

@main
struct NotePlannerApp: App {
    let container: ModelContainer
    
    var body: some Scene {
     
        WindowGroup {
            NotePlanListView()
        }
        .modelContainer(container)
    }
    init() {
        let schema = Schema([NotePlan.self])
        let config = ModelConfiguration("NotePlan", schema: schema)
        do {
            container = try ModelContainer(for: NotePlan.self, configurations: config)
        } catch {
            fatalError("Could not configure container")
        }
        print(URL.documentsDirectory.path(percentEncoded: false))
    }
}
