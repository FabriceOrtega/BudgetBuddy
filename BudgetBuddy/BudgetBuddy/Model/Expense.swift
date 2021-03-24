//
//  Expense.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 20/03/2021.
//

import Foundation

struct Expense: Identifiable {
    let title: String
    let description: String?
    let amount: Double
    let date: Date
    let category: ExpenseCategory
    
    var id = UUID()
    
    enum ExpenseCategory: String, Equatable, CaseIterable {
        case food = "Food"
        case shopping = "Shopping"
        case car = "Car"
        
        var id: String { self.rawValue }
    }
}
