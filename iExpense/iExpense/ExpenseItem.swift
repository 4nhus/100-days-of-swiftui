//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Anh Nguyen on 31/1/2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
