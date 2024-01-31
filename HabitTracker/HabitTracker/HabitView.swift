//
//  HabitView.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct HabitView: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.title)
                .font(.headline)
            Text(habit.description)
        }
    }
}

#Preview {
    HabitView(habit: Habit(title: "Title", description: "Description"))
}
