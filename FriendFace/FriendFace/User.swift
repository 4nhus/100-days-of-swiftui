//
//  User.swift
//  FriendFace
//
//  Created by Anh Nguyen on 1/2/2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    struct Friend: Codable, Identifiable, Hashable {
        let id: String
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, isActive, name, age, company, email, address, about, registeredString = "registered", tags, friends
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registeredString: String
    var registered: Date {
        ISO8601DateFormatter().date(from: registeredString) ?? Date.now
    }
    let tags: [String]
    let friends: [Friend]
}
