//
//  TimeConversion.swift
//  UnitConversion
//
//  Created by Alex Bùi on 10/05/2022.
//

import SwiftUI

struct TimeConversion: View {
    @State private var inputNumber: Double?
    @State private var inputUnit: UnitDuration = .seconds
    @State private var outputUnit: UnitDuration = .hours
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitDuration] = [.seconds, .minutes, .hours]
    
    var outputNumber: Double? {
        guard let inputNumber = inputNumber else { return nil }
        
        let inputTime = Measurement(value: inputNumber, unit: inputUnit)
        
        return inputTime.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Put your number here", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("This is where the magic happens")
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
                    Text("Result")
                }
            }
            .navigationTitle("Time Conversion")
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

struct TimeConversion_Previews: PreviewProvider {
    static var previews: some View {
        TimeConversion()
    }
}
