//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var order = (try? JSONDecoder().decode(Order.self, from: UserDefaults.standard.data(forKey: "order") ?? Data())) ?? Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.details.quantity)", value: $order.details.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.details.specialRequestEnabled)

                    if order.details.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.details.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.details.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
