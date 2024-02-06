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
}
