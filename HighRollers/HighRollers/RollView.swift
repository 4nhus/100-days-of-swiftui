//
//  RollView.swift
//  HighRollers
//
//  Created by Anh Nguyen on 7/2/2024.
//

import Combine
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
    
    @State var timer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
    @State private var dice = Dice.four
    @State private var isShowingChangeDice = false
    @State private var rollStartFlag = false
    @State private var rollFinishFlag = false
    @State private var flicksRemaining = 5
    @State private var result: Int?
    
    var body: some View {
        NavigationStack {
            Button("Roll \(dice.rawValue) sided dice") {
                rollStartFlag.toggle()
                timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
                rollFinishFlag.toggle()
            }
            .animation(.spring, value: result)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            Text(result != nil ? "\(result!)" : "")
                .font(.largeTitle)
                .accessibilityHidden(flicksRemaining == 0)
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
            .sensoryFeedback(.start, trigger: rollStartFlag)
            .sensoryFeedback(.success, trigger: rollFinishFlag)
            .onReceive(timer) { time in
                if flicksRemaining > 0 {
                    result = dice.roll()
                    flicksRemaining -= 1
                } else {
                    timer.upstream.connect().cancel()
                    modelContext.insert(Result(value: result!, diceSides: dice.rawValue, dateAdded: Date.now))
                    flicksRemaining = 5
                }
            }
        }
    }
}


#Preview {
    RollView()
        .modelContainer(for: Result.self)
}
