//
//  AddView.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses
    
    @State private var name = "Default expense name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code:  Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle($name)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}
