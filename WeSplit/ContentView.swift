//
//  ContentView.swift
//  WeSplit
//
//  Created by Mert Ali Hanbay on 17.07.2023.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 0

    @FocusState private var isAmauntFocused: Bool

    let tipPercentages: Array<Int> = [0, 10, 15, 20, 25, 50]

    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople + 2)
        let amountPerPerson: Double = totalCheck / peopleCount

        return amountPerPerson
    }

    var totalCheck: Double {
        let tip: Double = Double(tipPercentage)
        let tipValue: Double = checkAmount / 100 * tip
        let total: Double = checkAmount + tipValue

        return total
    }

    var localeCurrency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD"
        )
    }

    var body: some View {
        NavigationView {

            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: localeCurrency
                    )
                        .keyboardType(.decimalPad)
                        .focused($isAmauntFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<101) { people in
                            Text("\(people) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Tip percentage:")
                }

                Section {
                    Text(totalCheck, format: .number)
                } header: {
                    Text("Total check:")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person:")
                }

            }
                .navigationTitle("WeSplit")
                .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isAmauntFocused = false
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
