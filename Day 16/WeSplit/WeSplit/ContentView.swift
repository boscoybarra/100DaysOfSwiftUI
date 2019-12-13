import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeople) ?? 1)
        let tipSelection = Double(tipPercentages[tipPercentage])
//      we use the nil coalescing operator, ??, to ensure there’s always a valid value.
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalCheck: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
//      we use the nil coalescing operator, ??, to ensure there’s always a valid value.
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total amount to pay")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                } .navigationBarTitle("WeSplit!")
                
                Section(header: Text("How many people to split?")) {
                    TextField("Number of people", text: $numberOfPeople) {
//                     ForEach(2 ..< 100) {
//                        Text("\($0) people")
//                      }
                    } .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("\(totalPerPerson, specifier: "%.2f") €")
                }
                
                Section(header: Text("Total amount for the check + tip")) {
                    Text("\(totalCheck, specifier: "%.2f") €")
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
