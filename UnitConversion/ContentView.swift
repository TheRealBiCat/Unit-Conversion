//
//  ContentView.swift
//  UnitConversion
//
//  Created by Alex Bùi on 09/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .length
    
    enum Tab {
        case length
        case temp
        case time
        case volume
    }
    
    var body: some View {
        TabView(selection: $selection) {
            LengthConversion()
                .tabItem {
                    Label("Length", systemImage: "scribble.variable")
                }
            .tag(Tab.length)
            
            TemperatureConversion()
                .tabItem {
                    Label("Temperature", systemImage: "sun.max")
                }
                .tag(Tab.temp)
            
            TimeConversion()
                .tabItem {
                    Label("Time", systemImage: "clock")
                }
                .tag(Tab.time)
            
            VolumeConversion()
                .tabItem {
                    Label("Volume", systemImage: "rectangle.fill")
                }
                .tag(Tab.volume)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
