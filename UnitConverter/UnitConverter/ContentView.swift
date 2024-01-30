//
//  ContentView.swift
//  UnitConverter
//
//  Created by Anh Nguyen on 30/1/2024.
//

import SwiftUI

struct ContentView: View {
    private enum Unit: String {
        case temperature, length, time, volume
    }
    private let unitTypes: [Unit] = [.temperature, .length, .time, .volume]
    
    @State private var selectedUnitType: Unit = .length
    @State private var inputUnit: Dimension = UnitLength.millimeters
    @State private var outputUnit: Dimension = UnitLength.millimeters
    @State private var valueToConvert: Double = 0
    @FocusState private var valueToConvertIsFocused: Bool
    
    var selectedUnits: [Dimension] {
        switch selectedUnitType {
        case .temperature:
            [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
        case .length:
            [UnitLength.millimeters, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
        case .time:
            [UnitDuration.milliseconds, UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
        case .volume:
            [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
        }
    }
    var convertedValue: Double {
        Measurement(value: valueToConvert, unit: inputUnit).converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Picker("Type of units to convert", selection: $selectedUnitType) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section("Select your input unit") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(selectedUnits, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select your output unit") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(selectedUnits, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter your value in \(inputUnit.symbol) to convert") {
                    TextField("Value to convert", value: $valueToConvert, format: .number)
                        .keyboardType(.numberPad)
                        .focused($valueToConvertIsFocused)
                    
                }
                Section() {
                    Text("Your converted value is: \(convertedValue.formatted() + outputUnit.symbol)")
                }
            }
            .navigationTitle("Unit Converter")
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
