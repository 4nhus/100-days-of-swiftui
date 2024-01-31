//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct AddHabitView: View {
    let habits: Habits
    
    @State private var title = ""
    @State private var description = ""

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habbit details") {
                    VStack {
                        TextField("Title", text: $title)
                        
                        Divider()
                        
                        TextField("Description", text: $description)
                        
                        Divider()
                        
                        Button("Add habit") {
                            habits.addHabit(Habit(title: title, description: description))
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .toolbar {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddHabitView(habits: Habits())
}
