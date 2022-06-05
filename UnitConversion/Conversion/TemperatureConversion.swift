//
//  TemperatureConversion.swift
//  UnitConversion
//
//  Created by Alex Bùi on 10/05/2022.
//

import SwiftUI

struct TemperatureConversion: View {
    @State private var inputNumber: Double?
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .fahrenheit
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    var outputNumber: Double? {
        guard let inputNumber = inputNumber else { return nil }
        
        let inputTemp = Measurement(value: inputNumber, unit: inputUnit)
        
        return inputTemp.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Put your number here", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Your conversion happens here 🖤")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
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
            .navigationTitle("Temperature Conversion")
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

struct TemperatureConversion_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversion()
    }
}
