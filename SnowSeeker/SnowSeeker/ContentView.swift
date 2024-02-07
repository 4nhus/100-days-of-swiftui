//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftUI

struct ContentView: View {
    enum Sort: String, CaseIterable, Identifiable {
        case `default`, alphabetical, country
        
        var id: Self { self }
    }
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let defaultResorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var sortBy = Sort.default
    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ResortsListView(resorts: filteredResorts)
                .searchable(text: $searchText, prompt: "Search for a resort")
                .toolbar {
                    Menu("Sort resorts") {
                        Picker("Sorting by", selection: $sortBy) {
                            ForEach(Sort.allCases) { sort in
                                Text(sort.rawValue)
                            }
                        }
                    }
                }
                .onChange(of: sortBy) { oldValue, newValue in
                    switch sortBy {
                    case .default:
                        resorts = defaultResorts
                    case .alphabetical:
                        resorts = defaultResorts.sorted { $0.name < $1.name }
                    case .country:
                        resorts = defaultResorts.sorted { $0.country < $1.country }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
