//
//  ContentView.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses) { expense in
                        if expense.type == "Personal" {
                            ExpenseView(expense: expense)
                        }
                    }
                    .onDelete(perform: removeExpense)
                }
                Section("Business") {
                    ForEach(expenses) { expense in
                        if expense.type == "Business" {
                            ExpenseView(expense: expense)
                        }
                    }
                    .onDelete(perform: removeExpense)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Button("Add Expense", systemImage: "plus") {
                    }
                }
            }
        }
    }
    
    func removeExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Expense.self)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
