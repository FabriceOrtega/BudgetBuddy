//
//  AdditionViewModel.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 23/03/2021.
//

import Foundation

class AdditionViewModel: ObservableObject {
    
    // Reference to the Expenses class
    @Published var expenses = Expenses.shared
    
    // Refernec to the CoreData class
    @Published var storage = CoreDataStorage.shared
    
    // Properties coming from the view
    @Published var title:String = ""
    @Published var description:String = ""
    @Published var expenseDate: Date = Date()
    @Published var amountString:String = ""
    @Published var category:Expense.ExpenseCategory = Expense.ExpenseCategory.food
    
    // Date formatter
    let formatter = DateFormatter()
    
    
    // Method to create an expense object
    private func createExpenseObject()->Expense {
        
        //Format for the date
        formatter.dateFormat = "yyyy/MM/dd"
        let stringDate = formatter.string(from: expenseDate)
        let dateWithCorrectFormat = formatter.date(from: stringDate) ?? Date()
        
        //Convert amount in Double
        let amount = Double(amountString) ?? 0.0
        
        //create the object
        let expenseObject = Expense(title: title,
                                    description: description,
                                    amount: amount,
                                    date: dateWithCorrectFormat,
                                    category: category)
        
        return expenseObject
    }
    
    // Method to append the expense object in the expenses array
    func appendExpenseInArray(){
        // Append in the array
        expenses.expenses.append(createExpenseObject())
        
        // Save with CoreData
        storage.addNewExpense(expense: createExpenseObject())
        
    }
    
    
}
