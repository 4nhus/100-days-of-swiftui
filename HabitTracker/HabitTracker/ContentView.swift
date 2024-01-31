//
//  ContentView.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.getHabits()) { habit in
                    NavigationLink(value: habit) {
                        HabitView(habit: habit)
                    }
                    Divider()
                }
                .onDelete(perform: { indexSet in
                    habits.deleteHabbit(at: indexSet)
                })
                .navigationDestination(for: Habit.self) { habit in
                    HabitDetailsView(habit: habit, habits: habits)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("New habit") {
                    showAddHabit = true
                }
            }
        }
        .sheet(isPresented: $showAddHabit) {
            AddHabitView(habits: habits)
        }
    }
}

#Preview {
    ContentView()
}
