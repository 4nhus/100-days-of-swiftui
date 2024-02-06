//
//  Card.swift
//  Flashzilla
//
//  Created by Anh Nguyen on 6/2/2024.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    
    static let cardsURL = URL.documentsDirectory.appending(path: "cards.json")
    
    static func loadCards(cards: inout [Card]) {
        if let data = try? Data(contentsOf: cardsURL) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    static func saveCards(_ cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: cardsURL, options: [.atomic, .completeFileProtection])
        }
    }
}
