//
//  ExpenseView.swift
//  iExpense
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct ExpenseView: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.name)
                .font(.headline)
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .fontWeight(expense.amount < 10 ? .regular : expense.amount < 100 ? .bold : .heavy)
        }
    }
}
