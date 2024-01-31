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
            NavigationLink(value: mission) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()

                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
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
