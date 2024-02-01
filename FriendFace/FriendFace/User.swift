//
//  User.swift
//  FriendFace
//
//  Created by Anh Nguyen on 1/2/2024.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable, Hashable {
    @Model
    class Friend: Codable, Identifiable, Hashable {
        enum CodingKeys: String, CodingKey {
            case id, name
        }
        
        let id: String
        let name: String
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.name, forKey: .name)
        }
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registeredString = try container.decode(String.self, forKey: .registeredString)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registeredString, forKey: .registeredString)
        try container.encode(self.tags, forKey: .tags)
    }
}
