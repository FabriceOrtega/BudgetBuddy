//
//  Expenses.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 20/03/2021.
//

import Foundation

class Expenses: ObservableObject  {
    //singleton pattern
    static let shared = Expenses()
    
    // Refernec to the CoreData class
    let storage = CoreDataStorage.shared
    
    // Array of expenses
    @Published var expenses: [Expense] = []
    
    
    init() {
        // Fetch core data to fill the array
        expenses = storage.fetchExpenseList()
       
    }
    
}
