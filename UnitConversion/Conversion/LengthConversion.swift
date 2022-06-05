//
//  LengthConversion.swift
//  UnitConversion
//
//  Created by Alex Bùi on 10/05/2022.
//

import SwiftUI

struct LengthConversion: View {
    @State private var inputNumber: Double?
    @State private var inputUnit: UnitLength = .meters
    @State private var outputUnit: UnitLength = .feet
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var outputNumber: Double? {
        guard let inputNumber = inputNumber else { return nil }
        
        let inputMeasurement = Measurement(value: inputNumber, unit: inputUnit)
        
        return inputMeasurement.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Put your number here", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input Units", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Length conversion")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Your result is \(outputNumber?.formatted() ?? "") \(outputUnit.symbol)")
                } header: {
                    Text("Choose the unit you want to convert to")
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct LengthConversion_Previews: PreviewProvider {
    static var previews: some View {
        LengthConversion()
    }
}
