//
//  Habits.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import Foundation
import SwiftUI

@Observable
class Habits: Codable {
    var habits: [Habit] = (try? JSONDecoder().decode([Habit].self, from: UserDefaults.standard.data(forKey: "habits") ?? Data())) ?? [Habit]()
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
        save()
    }
    
    func getHabits() -> [Habit] {
        habits
    }
    
    func deleteHabbit(at indexes: IndexSet) {
        habits.remove(atOffsets: indexes)
        save()
    }
    
    func save() {
        let encodedHabits = try? JSONEncoder().encode(habits)
        UserDefaults.standard.set(encodedHabits, forKey: "habits")
    }
}
