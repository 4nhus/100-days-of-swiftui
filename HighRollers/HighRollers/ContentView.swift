//
//  ContentView.swift
//  HighRollers
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query private var results: [Result]
    
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Label("Roll", systemImage: "dice.fill")
                }
            
            ResultsView()
                .tabItem {
                    Label("Results", systemImage: "doc.fill")
                }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Result.self, configurations: config)
    return ContentView()
        .modelContainer(modelContainer)
}
