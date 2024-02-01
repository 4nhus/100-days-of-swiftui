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
    
    let sortOptions = ["name", "amount"]
    
    @State private var sortOption = "name"
    
    var sortOrder: [SortDescriptor<Expense>] {
        sortOption == "name" ? [SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)] : [SortDescriptor(\Expense.amount), SortDescriptor(\Expense.name)]
    }
    
    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                Menu("Sort expenses") {
                    Picker("Sorting by", selection: $sortOption) {
                        ForEach(sortOptions, id: \.self) { option in
                            Text(option)
                        }
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
