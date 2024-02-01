//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
