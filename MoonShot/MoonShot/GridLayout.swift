//
//  GridLayout.swift
//  MoonShot
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    MissionDisplayView(mission: mission)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationDestination(for: Mission.self) {
            MissionView(mission: $0, astronauts: astronauts)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return GridLayout(astronauts: astronauts, missions: missions)
}
