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
    let expenseType: String
    
    init(expenseType: String,  sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if expenseType == "Both" {
                return true
            } else {
                return expense.type == expenseType
            }
        }, sort: sortOrder)
        self.expenseType = expenseType
    }
    
    var body: some View {
        Section("\(expenseType == "Both" ? "Personal and business" : expenseType) expenses") {
            ForEach(expenses) { expense in
                ExpenseView(expense: expense)
            }
            .onDelete(perform: removeExpense)
        }
    }
    
    func removeExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
}
