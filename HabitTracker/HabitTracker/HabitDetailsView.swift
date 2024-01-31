//
//  HabitDetailsView.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct HabitDetailsView: View {
    let habit: Habit
    let habits: Habits
    
    var body: some View {
        VStack {
            Text(habit.description)
            
            Text("Completed: ^[\(habit.count) time](inflect: true)")
            
            Button("Record completion") {
                habit.count += 1
                habits.save()
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding()
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HabitDetailsView(habit: Habit(title: "Title", description: "Description"), habits: Habits())
}
