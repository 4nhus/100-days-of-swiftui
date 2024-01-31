//
//  Habit.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import Foundation

@Observable
class Habit: Codable, Identifiable, Hashable {
    var title: String
    var description: String
    var id = UUID()
    var count = 0
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(count)
    }
}
