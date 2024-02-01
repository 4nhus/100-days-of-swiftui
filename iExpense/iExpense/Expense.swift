//
//  Expense.swift
//  iExpense
//
//  Created by Anh Nguyen on 1/2/2024.
//

import Foundation
import SwiftData

@Model
class Expense {
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
