//
//  ContentView.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var expenses: [Expense]
    
    let expenseTypeOptions = ["Personal", "Business", "Both"]
    
    @State private var sortOrder = [SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)]
    @State private var expenseTypeChoice = "Both"
    
    var body: some View {
        NavigationStack {
            List {
                Section("Type of expense") {
                    Picker("Pick type(s) of expenses to show", selection: $expenseTypeChoice) {
                        ForEach(expenseTypeOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                ExpensesView(expenseType: expenseTypeChoice, sortOrder: sortOrder)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Menu("Sort expenses") {
                    Picker("Sorting by", selection: $sortOrder) {
                        Text("name")
                            .tag([SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)])
                        Text("amount")
                            .tag([SortDescriptor(\Expense.amount), SortDescriptor(\Expense.name)])
                    }
                }
                NavigationLink {
                    AddView()
                } label: {
                    Button("Add Expense", systemImage: "plus") {
                    }
                }
            }
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
