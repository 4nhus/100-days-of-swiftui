//
//  RollView.swift
//  HighRollers
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftData
import SwiftUI

struct RollView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        var id: Self { self }
        
        func roll() -> Int {
            Int.random(in: 1...self.rawValue)
        }
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var results: [Result]
    
    @State private var dice = Dice.four
    @State private var isShowingChangeDice = false
    
    var body: some View {
        NavigationStack {
            Button("Roll \(dice.rawValue) sided dice") {
                modelContext.insert(Result(value: dice.roll(), diceSides: dice.rawValue, dateAdded: Date.now))
            }
            .toolbar {
                Menu("Change dice") {
                    Picker("Dice", selection: $dice) {
                        ForEach(Dice.allCases) { dice in
                            Text("\(dice.rawValue) sided dice")
                        }
                    }
                }
            }
            .navigationTitle("Roll")
        }
    }
}
