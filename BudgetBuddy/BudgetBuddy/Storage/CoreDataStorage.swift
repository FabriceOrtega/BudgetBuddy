//
//  CoreDataStorage.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 25/03/2021.
//

import Foundation
import CoreData

class CoreDataStorage {
    
    //singleton pattern
    static let shared = CoreDataStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "ExpensesCoreData")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // Method to load the saved list
    func fetchExpenseList() -> [Expense] {
        let expenseList:[Expense]
        let fetchRequest:NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        if let rawTaskList = try? context.fetch(fetchRequest) {
            expenseList = rawTaskList.compactMap({ (rawExpense:CDExpense) -> Expense? in
                Expense(fromCoreDataObject: rawExpense)
            })
        } else {
            expenseList = []
        }
        return expenseList
    }
    
    // Method to add a new expense to the list
    func addNewExpense(expense:Expense) {
        let newExpense = CDExpense(context: context)
        newExpense.amount = expense.amount
        newExpense.category = expense.category.rawValue
        newExpense.date = expense.date
        newExpense.expenseDescription = expense.description
        newExpense.id = expense.id
        newExpense.title = expense.title
        saveData()
    }
    
    // Method to search in the list by an expense id
    private func fetchCDExpense(withId expenseId:UUID) -> CDExpense? {
        let fetchRequest:NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", expenseId as CVarArg)
        fetchRequest.fetchLimit = 1
        let fetchResult:[CDExpense]? = try? context.fetch(fetchRequest)
        return fetchResult?.first
    }
    
    func removeExpense(expense:Expense) {
        if let existingExpense = fetchCDExpense(withId: expense.id) {
            //remove existingExpense
            context.delete(existingExpense)
            saveData()
        }
    }
    
    // Method to save teh context
    private func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erreur pendant la sauvegarde CoreData : \(error.localizedDescription)")
            }
        }
    }
    
}

extension Expense {
    init?(fromCoreDataObject coreDataObject:CDExpense) {
        guard let id = coreDataObject.id,
              let title = coreDataObject.title else {
            return nil
        }
        self.id = id
        self.title = title
        self.amount = coreDataObject.amount
        self.category = Expense.ExpenseCategory(rawValue: coreDataObject.category!) ?? .food
        self.date = coreDataObject.date ?? Date()
        self.description = coreDataObject.expenseDescription
    }
}
