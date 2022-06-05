//
//  VolumeConversion.swift
//  UnitConversion
//
//  Created by Alex Bùi on 10/05/2022.
//

import SwiftUI

struct VolumeConversion: View {
    @State private var inputNumber: Double?
    @State private var inputUnit: UnitVolume = .milliliters
    @State private var outputUnit: UnitVolume = .cups
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitVolume] = [.milliliters, .liters, .teaspoons, .tablespoons, .cups, .pints, .gallons]
    
    var outputNumber: Double? {
        guard let inputNumber = inputNumber else { return nil }
        
        let inputVolume = Measurement(value: inputNumber, unit: inputUnit)
        
        return inputVolume.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Put your number here", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input Number", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("This is where the magic happens")
                }
                
                Section {
                    Picker("Output Number", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Your result is \(outputNumber?.formatted() ?? "") \(outputUnit.symbol)")
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Volume Conversion")
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

struct VolumeConversion_Previews: PreviewProvider {
    static var previews: some View {
        VolumeConversion()
    }
}
