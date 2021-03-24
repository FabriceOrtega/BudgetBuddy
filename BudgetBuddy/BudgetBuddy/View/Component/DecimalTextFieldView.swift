//
//  DecimalTextFieldView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 23/03/2021.
//

import SwiftUI

struct DecimalTextFieldView: View {
    
    @Binding var decimalValue: String

    @State private var lastValidInput: String?
    
    //let localizedSeparator = NumberFormatter().decimalSeparator!
    
    var inputValidator: Binding<String> {
        
        Binding<String>(
            get: { self.lastValidInput ?? String("\(self.decimalValue)") },
            set: {
                                
                let matchesInputFormat = $0.range(of: "^[0-9]{0,9}([.][0-9]{0,9})?$", options: .regularExpression) != nil
                
                
                if matchesInputFormat {
                    self.decimalValue = String($0)
                    self.lastValidInput = $0
                } else {
                    self.inputValidator.wrappedValue = self.lastValidInput ?? ""
                }
        })
    }
    
    var body: some View {
        HStack {
            TextField("", text: inputValidator)
                .keyboardType(.numbersAndPunctuation)
                .frame(height: 30)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.leading, .trailing], 4)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))

        }
        
    }
}

struct DecimalTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DecimalTextFieldView(decimalValue: .constant("15.5"))
    }
}
