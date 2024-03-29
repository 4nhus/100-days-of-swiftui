//
//  ResortsListView.swift
//  SnowSeeker
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftUI

struct ResortsListView: View {
    let resorts: [Resort]
    
    @StateObject private var favorites = Favorites()
    
    var body: some View {
        List(resorts) { resort in
            NavigationLink {
                ResortView(resort: resort)
                    .environmentObject(favorites)
            } label: {
                HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Resorts")
    }
}

#Preview {
    ResortsListView(resorts: Bundle.main.decode("resorts.json"))
}
