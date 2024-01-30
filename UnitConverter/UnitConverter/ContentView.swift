//
//  ContentView.swift
//  UnitConverter
//
//  Created by Anh Nguyen on 30/1/2024.
//

import SwiftUI

struct ContentView: View {
    private let units: [UnitLength] = [UnitLength.millimeters, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    @State private var inputUnit: UnitLength = UnitLength.millimeters
    @State private var outputUnit: UnitLength = UnitLength.millimeters
    @State private var valueToConvert: Double = 0
    @FocusState private var valueToConvertIsFocused: Bool
    
    var convertedValue: Double {
        Measurement(value: valueToConvert, unit: inputUnit).converted(to: outputUnit).value
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select your input unit") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select your output unit") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter your value to convert") {
                    TextField("Value to convert", value: $valueToConvert, format: .number)
                        .keyboardType(.numberPad)
                        .focused($valueToConvertIsFocused)
                    
                }
                Section("Your converted value is") {
                    Text("\(convertedValue.formatted() + outputUnit.symbol)")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                if valueToConvertIsFocused {
                    Button("Done") {
                        valueToConvertIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
