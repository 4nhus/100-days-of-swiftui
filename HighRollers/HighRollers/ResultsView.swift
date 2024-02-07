//
//  ResultsView.swift
//  HighRollers
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftData
import SwiftUI

struct ResultsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    @Query(sort: \Result.dateAdded, order: .reverse) private var results: [Result]
    
    @State private var resultSelections = Set<PersistentIdentifier>()
    
    var body: some View {
        NavigationStack {
            List(results, selection: $resultSelections) { result in
                Text("\(result.value) from a \(result.diceSides) sided dice")
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(result)
                            try? modelContext.save()
                        }
                    }
            }
            .navigationTitle("Results")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .destructiveAction) {
                    if resultSelections.count > 0 {
                        Button("Delete results", systemImage: "trash.fill") {
                            for selection in resultSelections {
                                let result = results.first(where: { $0.id == selection })!
                                modelContext.delete(result)
                            }
                            try? modelContext.save()
                            resultSelections.removeAll()
                            editMode?.wrappedValue = .inactive
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ResultsView()
        .modelContainer(for: Result.self)
}
