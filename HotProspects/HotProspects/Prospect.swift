//
//  Prospect.swift
//  HotProspects
//
//  Created by Anh Nguyen on 5/2/2024.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }
}
