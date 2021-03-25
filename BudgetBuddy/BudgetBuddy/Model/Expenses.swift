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
    
    
//    // Test values
//    var date1: Date
//    var date2: Date
//    var date3: Date
//
//    let formatter = DateFormatter()
    
    init() {
        // NE PAS EFFACER
        expenses = storage.fetchExpenseList()
        
        
//        formatter.dateFormat = "yyyy/MM/dd"
//        date1 = formatter.date(from: "2021/03/24") ?? Date()
//        date2 = formatter.date(from: "2021/03/23") ?? Date()
//        date3 = formatter.date(from: "2021/03/25") ?? Date()
//        
//        let exp1 = Expense(title: "test1", description: nil, amount: 130, date: date1, category: .shopping)
//        let exp2 = Expense(title: "test2", description: nil, amount: 180, date: date2, category: .food)
//        let exp3 = Expense(title: "test3", description: nil, amount: 10, date: date3, category: .shopping)
//        let exp4 = Expense(title: "test4", description: nil, amount: 25, date: date2, category: .food)
//        let exp5 = Expense(title: "test5", description: nil, amount: 35, date: date3, category: .food)
//        let exp6 = Expense(title: "test6", description: nil, amount: 140, date: date2, category: .car)
//        let exp7 = Expense(title: "test7", description: nil, amount: 261, date: date3, category: .car)
//        let exp8 = Expense(title: "test8", description: nil, amount: 21.2, date: date3, category: .food)
//
//        expenses.append(exp1)
//        expenses.append(exp2)
//        expenses.append(exp3)
//        expenses.append(exp4)
//        expenses.append(exp5)
//        expenses.append(exp6)
//        expenses.append(exp7)
//        expenses.append(exp8)
       
    }
    
    
}
