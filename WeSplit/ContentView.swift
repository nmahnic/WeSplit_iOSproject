//
//  ContentView.swift
//  WeSplit
//
//  Created by Nico Mahnic on 03/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount : Double?
    @State private var numberOfPeople : Int = 0
    @State private var tipPercentage : Int = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    
    var currency : FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ??
            Locale(identifier: "en-US").currency!.identifier
        return FloatingPointFormatStyle<Double>.Currency( code: currencyCode )
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return total / peopleCount
    }
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount ?? 0) / 100 * tipSelection
        return (checkAmount ?? 0) + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    Picker(
                        "Number of people",
                        selection: $numberOfPeople
                    ) {
                        ForEach(2 ..< 10) {
                            Text("\($0) people")
                        }
                    }
                    
                    TextField(
                        "Amount spent",
                        value: $checkAmount,
                        format: currency
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                
                Section {
                    Picker(
                        "Select tip",
                        selection: $tipPercentage
                    ){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(total,format: currency)
                } header: {
                    Text("Check with tip")
                }
                
                Section {
                    Text(totalPerPerson,format: currency)
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
