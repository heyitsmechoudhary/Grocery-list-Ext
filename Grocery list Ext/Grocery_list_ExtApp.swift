//
//  Grocery_list_ExtApp.swift
//  Grocery list Ext
//
//  Created by Rahul choudhary on 30/01/25.
//

import SwiftUI
import SwiftData

@main
struct Grocery_list_ExtApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:Item.self)
        }
    }
}
