//
//  ExpenseView.swift
//  iExpense
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct ExpenseView: View {
    let expense: Expense
    
    var currencyAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currencySymbol ?? "usd"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: expense.amount))!
    }
    
    var body: some View {
        HStack {
            Text(expense.name)
                .font(.headline)
            
            Spacer()
            
            Text(currencyAmount)
                .fontWeight(expense.amount < 10 ? .regular : expense.amount < 100 ? .bold : .heavy)
        }
        .accessibilityElement()
        .accessibilityLabel("\(expense.name), \(currencyAmount)")
        .accessibilityHint("\(expense.type) expense")
    }
}
