//
//  AdditionView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 23/03/2021.
//

import SwiftUI

struct AdditionView: View {
    // Return to budget view
    @Binding var additionViewIsShown: Bool
    
    // Reference to the view model
    @ObservedObject var additionViewModel = AdditionViewModel()
    
    var body: some View {
        
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Title")
                        .bold()
                        .padding(.bottom)
                    
                    TextField("", text: $additionViewModel.title)
                        .frame(height: 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding(.bottom)
                    
                    Text("Description (optional)")
                        .bold()
                        .padding(.bottom)
                    
                    TextField("", text: $additionViewModel.description)
                        .frame(height: 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding(.bottom)
                    
                    Text("Exepense date")
                        .bold()
                        .padding(.bottom)
                    
                    HStack{
                        DatePicker.init(selection: $additionViewModel.expenseDate, displayedComponents: .date, label: {
                            EmptyView()
                        })
                        .labelsHidden()
                        .datePickerStyle(DefaultDatePickerStyle())
                        
                        Spacer()
                    }.padding(.bottom)
                    
                    
                    Text("Amount")
                        .bold()
                        .padding(.bottom)
                    
                    DecimalTextFieldView(decimalValue: $additionViewModel.amountString)
                        .padding(.bottom)
                    
                    Text("Category")
                        .bold()
                    
                    Picker("", selection: $additionViewModel.category) {
                        ForEach(Expense.ExpenseCategory.allCases, id: \.id){ value in
                            Text(value.rawValue).tag(value)
                        }
                    }
                    .frame(height: 80)
                    .clipped()
                }
            }
            
            
            
            Spacer()

            Button(action: {
                additionViewIsShown = false
                additionViewModel.appendExpenseInArray()
            }, label: {
                Text("Add").font(.title2)
            })
            
            
            
            
        }.padding()
        
    }
    
}

struct AdditionView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionView(additionViewIsShown: .constant(true))
    }
}
