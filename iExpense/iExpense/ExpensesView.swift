//
//  ExpensesView.swift
//  iExpense
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    init(sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(sort: sortOrder)
    }
    
    var body: some View {
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
    }
    
    func removeExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
}
