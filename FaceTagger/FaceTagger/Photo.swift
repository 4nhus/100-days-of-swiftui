//
//  Photo.swift
//  FaceTagger
//
//  Created by Anh Nguyen on 3/2/2024.
//

import Foundation

struct Photo: Codable, Comparable, Identifiable, Hashable {
    var id = UUID()
    let data: Data
    let name: String
    let latitude: Double
    let longitude: Double
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
