//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
