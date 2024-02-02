//
//  ListLayout.swift
//  MoonShot
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            MissionDisplayView(mission: mission)
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        .navigationDestination(for: Mission.self) {
            MissionView(mission: $0, astronauts: astronauts)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListLayout(astronauts: astronauts, missions: missions)
}
