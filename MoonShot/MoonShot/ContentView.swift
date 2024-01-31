//
//  ContentView.swift
//  MoonShot
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(showingGrid ? "Display as list" : "Display as grid") {
                    showingGrid.toggle()
                }
                .foregroundStyle(.white.opacity(0.7))
            }
        }
        .tint(.primary)
    }
}

#Preview {
    ContentView()
}
