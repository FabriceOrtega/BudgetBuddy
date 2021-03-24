//
//  ExpensesViewModel.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 22/03/2021.
//

import Foundation
import SwiftUI

class ExpensesViewModel: ObservableObject {
    
    // Reference to the Expenses class
    @Published var expenses = Expenses.shared
    
    //Display mode (can be day, month or year)
    @Published var displayMode: DisplayMode = DisplayMode.day
    
    // Filter the expenses according the date, month or year
    @Published var filteredExpenses: [Expense] = []
    @Published var totalFileteredExpense = 0.0
    @Published var chosenDate: Date = Date()
    
    // Array of Category objects
    @Published var categoryArray: [Category] = []
    
    // Total expenses per category
    var foodExpenses = 0.0
    var foodExpensesArray: [Expense] = []
    var foodRatio: Float = 1.0
    
    var clotheExpenses = 0.0
    var clotheExpensesArray: [Expense] = []
    var clotheRatio: Float = 1.0
    
    var carExpenses = 0.0
    var carExpensesArray: [Expense] = []
    var carRatio: Float = 1.0
    
    
    // Maximum amount category
    var maxAmount: Double {
        max(clotheExpenses, foodExpenses, carExpenses)
    }
    
    // Date formatter
    let formatter = DateFormatter()
    

    init() {
        // Date format
        formatter.dateFormat = "yyyy/MM/dd"
        
        // Call the method to filter according the date
        filterExpenses()
    }
    
    // Enum for display mode
    enum DisplayMode{
        case day, month, year
    }
    
    // Categoray structure to be able to deal and sort objects
    struct Category{
        var categoryName: String
        var categoryColor: Color
        var categoryExpense: Double
        var expenseArray: [Expense]
        var categoryRatio : Float
        var categoryImageName: String
    }
    

    
    // Methpd to filter accoring the parameters
    func filterExpenses() {
        
        switch displayMode {
        case .day:
            // Upadte date format
            let stringDate = formatter.string(from: chosenDate)
            let dateWithCorrectFormat = formatter.date(from: stringDate)
            
            // Filter according the chosen date with correct format
            filteredExpenses = expenses.expenses.filter { $0.date == dateWithCorrectFormat }
        
        case .month:
            // Filter according the chosen month (currently december 2021)
            filteredExpenses = expenses.expenses.filter { Calendar.current.component(.month, from: $0.date) == 12 && Calendar.current.component(.year, from: $0.date) == 2021 }
        
        case .year:
            // Filter according the chosen month (currently 2021)
            filteredExpenses = expenses.expenses.filter { Calendar.current.component(.year, from: $0.date) == 2021 }
        }
        
 
        calculateTheTotalFilteredExpense()
        
        // Filter and calculate by category
        //objectWillChange.send()
        calculateEachCateroy()
    }
    
    
    // Method to calculate the total amount
    private func calculateTheTotalFilteredExpense(){
        // reinitiliase the total amount
        totalFileteredExpense = 0.0
        // for in loop
        for expense in filteredExpenses {
            totalFileteredExpense += expense.amount
        }
    }
    
    // Method to filter by category
    private func fiterByCategory(category: Expense.ExpenseCategory) -> [Expense] {
        let categoryExpenseArray = filteredExpenses.filter { $0.category == category }
        return categoryExpenseArray
    }
    
    // Method to calculate the total expense of the category
    private func calculateTotalAmountByCategory(categoryExpenseArray: [Expense]) -> Double {
        var categoryTotal = 0.0
        // For in loop
        for expense in categoryExpenseArray {
            categoryTotal += expense.amount
        }
        return categoryTotal
    }
    
    // Calculate the ratio for each category
    private func calcluateRatioByCategory(expense: Double)->Float {
        Float(expense)/Float(maxAmount)
    }
    
    // Method to calculate each category
    private func calculateEachCateroy(){
        // Filter the category arrays
        foodExpensesArray = fiterByCategory(category: .food)
        clotheExpensesArray = fiterByCategory(category: .shopping)
        carExpensesArray = fiterByCategory(category: .car)
        
        // Calculate the category expenses
        foodExpenses = calculateTotalAmountByCategory(categoryExpenseArray: foodExpensesArray)
        clotheExpenses = calculateTotalAmountByCategory(categoryExpenseArray: clotheExpensesArray)
        carExpenses = calculateTotalAmountByCategory(categoryExpenseArray: carExpensesArray)
        
        // Calculate the category ratios
        foodRatio = calcluateRatioByCategory(expense: foodExpenses)
        clotheRatio = calcluateRatioByCategory(expense: clotheExpenses)
        carRatio = calcluateRatioByCategory(expense: carExpenses)
        
        // Create objects, append in the array and sort it
        createCategoryObjects()
        
        
    }
    
    // Method to create category objects
    private func createCategoryObjects() {
        
        // Create the category objects
        let foodObject = Category(categoryName: "Food", categoryColor: .blue, categoryExpense: foodExpenses, expenseArray: foodExpensesArray, categoryRatio: foodRatio, categoryImageName: "🍔")
        
        let clotheObject = Category(categoryName: "Shopping", categoryColor: .purple, categoryExpense: clotheExpenses, expenseArray: clotheExpensesArray, categoryRatio: clotheRatio, categoryImageName: "👜")
        
        let carObject = Category(categoryName: "Car", categoryColor: .orange, categoryExpense: carExpenses, expenseArray: carExpensesArray, categoryRatio: carRatio, categoryImageName: "🚙")
        
        // Clear the category array
        categoryArray.removeAll()
        
        // Append the objects in the array
        categoryArray.append(foodObject)
        categoryArray.append(clotheObject)
        categoryArray.append(carObject)
        
        // Sort the array by expense
        categoryArray.sort { (expense1, expense2) -> Bool in
            expense1.categoryExpense > expense2.categoryExpense
        }
        
    }
    
    
    
}
