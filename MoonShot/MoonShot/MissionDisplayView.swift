//
//  MissionDisplayView.swift
//  MoonShot
//
//  Created by Anh Nguyen on 2/2/2024.
//

import SwiftUI

struct MissionDisplayView: View {
    let mission: Mission
    var body: some View {
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
        .accessibilityElement()
        .accessibilityLabel("\(mission.displayName) space mission, dated \(mission.fullFormattedLaunchDate)")
        .accessibilityHint("Link to more details about \(mission.displayName)")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return MissionDisplayView(mission: missions[0])
}
