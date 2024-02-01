//
//  Friend.swift
//  FriendFace
//
//  Created by Anh Nguyen on 2/2/2024.
//

import Foundation
import SwiftData

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
