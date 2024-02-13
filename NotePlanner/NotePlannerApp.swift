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
    
    
    var body: some Scene {
        WindowGroup {
            NotePlanListView()
        }
        .modelContainer(for: NotePlan.self)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
