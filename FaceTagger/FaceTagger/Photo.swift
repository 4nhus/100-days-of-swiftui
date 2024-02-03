//
//  Photo.swift
//  FaceTagger
//
//  Created by Anh Nguyen on 3/2/2024.
//

import Foundation

struct Photo: Codable, Comparable, Identifiable, Hashable {
    var id = UUID()
    var data: Data
    var name: String
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
