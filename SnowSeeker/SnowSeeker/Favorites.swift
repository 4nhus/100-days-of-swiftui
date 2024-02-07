//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Anh Nguyen on 7/2/2024.
//

import SwiftUI

class Favorites: ObservableObject, Codable {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    static let url = URL.documentsDirectory.appending(path: "favorites.json")
    
    init() {
        do {
            let data = try Data(contentsOf: Favorites.url)
            let decodedFavorites = try JSONDecoder().decode(Favorites.self, from: data)
            self.resorts = decodedFavorites.resorts
        }
        catch {
            self.resorts = []
        }
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(self) {
            try? data.write(to: Favorites.url)
        }
    }
}
