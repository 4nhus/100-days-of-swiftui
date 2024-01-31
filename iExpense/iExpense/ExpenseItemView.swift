//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct ExpenseItemView: View {
    let item: ExpenseItem
    
    init(_ item: ExpenseItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .fontWeight(item.amount < 10 ? .regular : item.amount < 100 ? .bold : .heavy)
        }
    }
}
