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
    
    // Refernec to the CoreData class
    @Published var storage = CoreDataStorage.shared
    
    //Display mode (can be day, month or year)
    @Published var displayMode: DisplayMode = DisplayMode.day
    
    // Filter the expenses according the date, month or year
    @Published var filteredExpenses: [Expense] = []
    @Published var totalFileteredExpense = 0.0
    @Published var chosenDate: Date = Date()
    
    // Array of Category objects
    @Published var categoryArray: [Category] = []
    
    // Total expenses per category
    var houseExpenses = 0.0
    var houseExpensesArray: [Expense] = []
    var houseRatio: Float = 1.0
    
    var subscriptionsExpenses = 0.0
    var subscriptionsExpensesArray: [Expense] = []
    var subscriptionsRatio: Float = 1.0
    
    var carExpenses = 0.0
    var carExpensesArray: [Expense] = []
    var carRatio: Float = 1.0
    
    var travelExpenses = 0.0
    var travelExpensesArray: [Expense] = []
    var travelRatio: Float = 1.0
    
    var powerExpenses = 0.0
    var powerExpensesArray: [Expense] = []
    var powerRatio: Float = 1.0
    
    var phoneExpenses = 0.0
    var phoneExpensesArray: [Expense] = []
    var phoneRatio: Float = 1.0
    
    var foodExpenses = 0.0
    var foodExpensesArray: [Expense] = []
    var foodRatio: Float = 1.0
    
    var otherGroceriresExpenses = 0.0
    var otherGroceriresExpensesArray: [Expense] = []
    var otherGroceriresRatio: Float = 1.0
    
    var shoppingExpenses = 0.0
    var shoppingExpensesArray: [Expense] = []
    var shoppingRatio: Float = 1.0
    
    var taxesExpenses = 0.0
    var taxesExpensesArray: [Expense] = []
    var taxesRatio: Float = 1.0
    
    var activitiesExpenses = 0.0
    var activitiesExpensesArray: [Expense] = []
    var activitiesRatio: Float = 1.0
    
    var heathExpenses = 0.0
    var heathExpensesArray: [Expense] = []
    var heathRatio: Float = 1.0
    
    var petsExpenses = 0.0
    var petsExpensesArray: [Expense] = []
    var petsRatio: Float = 1.0
    
    var otherExpenses = 0.0
    var otherExpensesArray: [Expense] = []
    var otherRatio: Float = 1.0
    

    // Maximum amount category
    var maxAmount: Double {
        max(houseExpenses, subscriptionsExpenses, carExpenses,travelExpenses, powerExpenses, phoneExpenses, foodExpenses, otherGroceriresExpenses, shoppingExpenses, taxesExpenses, activitiesExpenses, heathExpenses, petsExpenses, otherExpenses)
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
        case day, month
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
            // Extract month from the chosen date
            var chosenMonth: Int {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM"
                let monthString = dateFormatter.string(from: chosenDate)
                return Int(monthString) ?? 0
            }
            
            // Extract year from the chosen date
            var chosenYear: Int {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                let yearString = dateFormatter.string(from: chosenDate)
                return Int(yearString) ?? 0
            }
            
            // Filter according the chosen month (currently december 2021)
            filteredExpenses = expenses.expenses.filter { Calendar.current.component(.month, from: $0.date) == chosenMonth && Calendar.current.component(.year, from: $0.date) == chosenYear }
        
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
        houseExpensesArray = fiterByCategory(category: .house)
        subscriptionsExpensesArray = fiterByCategory(category: .subscriptions)
        carExpensesArray = fiterByCategory(category: .car)
        travelExpensesArray = fiterByCategory(category: .travel)
        powerExpensesArray = fiterByCategory(category: .power)
        phoneExpensesArray = fiterByCategory(category: .phoneInternet)
        foodExpensesArray = fiterByCategory(category: .food)
        otherGroceriresExpensesArray = fiterByCategory(category: .otherGroceries)
        shoppingExpensesArray = fiterByCategory(category: .shopping)
        taxesExpensesArray = fiterByCategory(category: .taxes)
        activitiesExpensesArray = fiterByCategory(category: .activities)
        heathExpensesArray = fiterByCategory(category: .health)
        petsExpensesArray = fiterByCategory(category: .pets)
        otherExpensesArray = fiterByCategory(category: .others)
        
        // Calculate the category expenses
        houseExpenses = calculateTotalAmountByCategory(categoryExpenseArray: houseExpensesArray)
        subscriptionsExpenses = calculateTotalAmountByCategory(categoryExpenseArray: subscriptionsExpensesArray)
        carExpenses = calculateTotalAmountByCategory(categoryExpenseArray: carExpensesArray)
        travelExpenses = calculateTotalAmountByCategory(categoryExpenseArray: travelExpensesArray)
        powerExpenses = calculateTotalAmountByCategory(categoryExpenseArray: powerExpensesArray)
        phoneExpenses = calculateTotalAmountByCategory(categoryExpenseArray: phoneExpensesArray)
        foodExpenses = calculateTotalAmountByCategory(categoryExpenseArray: foodExpensesArray)
        otherGroceriresExpenses = calculateTotalAmountByCategory(categoryExpenseArray: otherGroceriresExpensesArray)
        shoppingExpenses = calculateTotalAmountByCategory(categoryExpenseArray: shoppingExpensesArray)
        taxesExpenses = calculateTotalAmountByCategory(categoryExpenseArray: taxesExpensesArray)
        activitiesExpenses = calculateTotalAmountByCategory(categoryExpenseArray: activitiesExpensesArray)
        heathExpenses = calculateTotalAmountByCategory(categoryExpenseArray: heathExpensesArray)
        petsExpenses = calculateTotalAmountByCategory(categoryExpenseArray: petsExpensesArray)
        otherExpenses = calculateTotalAmountByCategory(categoryExpenseArray: otherExpensesArray)
        
        // Calculate the category ratios
        houseRatio = calcluateRatioByCategory(expense: houseExpenses)
        subscriptionsRatio = calcluateRatioByCategory(expense: subscriptionsExpenses)
        carRatio = calcluateRatioByCategory(expense: carExpenses)
        travelRatio = calcluateRatioByCategory(expense: travelExpenses)
        powerRatio = calcluateRatioByCategory(expense: powerExpenses)
        phoneRatio = calcluateRatioByCategory(expense: phoneExpenses)
        foodRatio = calcluateRatioByCategory(expense: foodExpenses)
        otherGroceriresRatio = calcluateRatioByCategory(expense: otherGroceriresExpenses)
        shoppingRatio = calcluateRatioByCategory(expense: shoppingExpenses)
        taxesRatio = calcluateRatioByCategory(expense: taxesExpenses)
        activitiesRatio = calcluateRatioByCategory(expense: activitiesExpenses)
        heathRatio = calcluateRatioByCategory(expense: heathExpenses)
        petsRatio = calcluateRatioByCategory(expense: petsExpenses)
        otherRatio = calcluateRatioByCategory(expense: otherExpenses)
        
        // Create objects, append in the array and sort it
        createCategoryObjects()
        
        
    }
    
    // Method to create category objects
    private func createCategoryObjects() {
        
        // Create the category objects
        let houseObject = Category(categoryName: "House", categoryColor: Color("houseColor"), categoryExpense: houseExpenses, expenseArray: houseExpensesArray, categoryRatio: houseRatio, categoryImageName: "House")
        
        let subscriptionsObject = Category(categoryName: "Subscriptions", categoryColor: Color("subscriptionsColor"), categoryExpense: subscriptionsExpenses, expenseArray: subscriptionsExpensesArray, categoryRatio: subscriptionsRatio, categoryImageName: "Subscriptions")
        
        let carObject = Category(categoryName: "Car", categoryColor: Color("carColor"), categoryExpense: carExpenses, expenseArray: carExpensesArray, categoryRatio: carRatio, categoryImageName: "Car")
        
        let travelObject = Category(categoryName: "Travel", categoryColor: Color("travelColor"), categoryExpense: travelExpenses, expenseArray: travelExpensesArray, categoryRatio: travelRatio, categoryImageName: "Travel")
        
        let powerObject = Category(categoryName: "Power(Electricity,water...)", categoryColor: Color("powerColor"), categoryExpense: powerExpenses, expenseArray: powerExpensesArray, categoryRatio: powerRatio, categoryImageName: "Power")
        
        let phoneObject = Category(categoryName: "Phone/Internet", categoryColor: Color("phoneColor"), categoryExpense: phoneExpenses, expenseArray: phoneExpensesArray, categoryRatio: phoneRatio, categoryImageName: "Phone")
        
        let foodObject = Category(categoryName: "Food", categoryColor: Color("foodColor"), categoryExpense: foodExpenses, expenseArray: foodExpensesArray, categoryRatio: foodRatio, categoryImageName: "Food")
        
        let otherGroceriesObject = Category(categoryName: "Other groceries", categoryColor: Color("otherGroceriesColor"), categoryExpense: otherGroceriresExpenses, expenseArray: otherGroceriresExpensesArray, categoryRatio: otherGroceriresRatio, categoryImageName: "OtherG")
        
        let shoppingObject = Category(categoryName: "Shopping", categoryColor: Color("shoppingColor"), categoryExpense: shoppingExpenses, expenseArray: shoppingExpensesArray, categoryRatio: shoppingRatio, categoryImageName: "Shopping")
        
        let taxesObject = Category(categoryName: "Taxes", categoryColor: Color("taxesColor"), categoryExpense: taxesExpenses, expenseArray: taxesExpensesArray, categoryRatio: taxesRatio, categoryImageName: "Taxes")
        
        let activitiesObject = Category(categoryName: "Activities", categoryColor: Color("activitiesColor"), categoryExpense: activitiesExpenses, expenseArray: activitiesExpensesArray, categoryRatio: activitiesRatio, categoryImageName: "Activities")
        
        let healthObject = Category(categoryName: "Health", categoryColor: Color("healthColor"), categoryExpense: heathExpenses, expenseArray: heathExpensesArray, categoryRatio: heathRatio, categoryImageName: "Health")
        
        let petsObject = Category(categoryName: "Pets", categoryColor: Color("petsColor"), categoryExpense: petsExpenses, expenseArray: petsExpensesArray, categoryRatio: petsRatio, categoryImageName: "Pets")
        
        let othersObject = Category(categoryName: "Others", categoryColor: Color("otherColor"), categoryExpense: otherExpenses, expenseArray: otherExpensesArray, categoryRatio: otherRatio, categoryImageName: "Other")
        
        
        // Clear the category array
        categoryArray.removeAll()
        
        // Append the objects in the array
        categoryArray.append(houseObject)
        categoryArray.append(subscriptionsObject)
        categoryArray.append(carObject)
        categoryArray.append(travelObject)
        categoryArray.append(powerObject)
        categoryArray.append(phoneObject)
        categoryArray.append(foodObject)
        categoryArray.append(otherGroceriesObject)
        categoryArray.append(shoppingObject)
        categoryArray.append(taxesObject)
        categoryArray.append(activitiesObject)
        categoryArray.append(healthObject)
        categoryArray.append(petsObject)
        categoryArray.append(othersObject)
        
        // Sort the array by expense
        categoryArray.sort { (expense1, expense2) -> Bool in
            expense1.categoryExpense > expense2.categoryExpense
        }
        
    }
    
    
    
}
