//
//  Result.swift
//  HighRollers
//
//  Created by Anh Nguyen on 7/2/2024.
//

import Foundation
import SwiftData

@Model
class Result {
    let value: Int
    let diceSides: Int
    var dateAdded = Date.now
    
    init(value: Int, diceSides: Int, dateAdded: Date) {
        self.value = value
        self.diceSides = diceSides
        self.dateAdded = dateAdded
    }
}
