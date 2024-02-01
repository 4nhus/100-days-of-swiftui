//
//  Order.swift
//  CupcakeCorner
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _details = "details"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    struct Details: Codable {
        var type = 0
        var quantity = 3
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
    }
    
    var details = Details() {
        didSet {
            saveOrder()
        }
    }
    
    var hasInvalidAddress: Bool {
        return details.name.isBlank || details.streetAddress.isBlank || details.city.isBlank || details.zip.isBlank
    }
    var cost: Double {
        // $2 per cake
        var cost = Double(details.quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(details.type) / 2)
        
        // $1/cake for extra frosting
        if details.extraFrosting {
            cost += Double(details.quantity)
        }
        
        // $0.50/cake for sprinkles
        if details.addSprinkles {
            cost += Double(details.quantity) / 2
        }
        
        return cost
    }
    
    func saveOrder() {
        let encodedOrder = try? JSONEncoder().encode(self)
        UserDefaults.standard.set(encodedOrder, forKey: "order")
    }
}

extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
