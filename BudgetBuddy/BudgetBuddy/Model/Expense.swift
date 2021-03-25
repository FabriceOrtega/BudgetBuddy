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
        case house = "House"
        case subscriptions = "Subscriptions"
        case car = "Car"
        case travel = "Travel"
        case power = "Power(Electricty, water...)"
        case phoneInternet = "Phone/Internet"
        case food = "Food"
        case otherGroceries = "Other groceries"
        case shopping = "Shopping"
        case taxes = "Taxes"
        case activities = "Activities"
        case health = "Health"
        case pets = "Pets"
        case others = "Others"
        
        var id: String { self.rawValue }
    }
}
