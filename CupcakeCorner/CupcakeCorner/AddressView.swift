//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.details.name)
                TextField("Street Address", text: $order.details.streetAddress)
                TextField("City", text: $order.details.city)
                TextField("Zip", text: $order.details.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasInvalidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
