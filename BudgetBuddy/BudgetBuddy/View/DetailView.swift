//
//  DetailView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 23/03/2021.
//

import SwiftUI

struct DetailView: View {
    // Reference to the view model
    @ObservedObject var expensesViewModel = ExpensesViewModel()
    
    // Get the array from the category
    @Binding var totalArray: [Expense]
    
    // Return to budget view
    @Binding var detailViewIsShown: Bool
    
    // View mode (month or day)
    @Binding var viewMode: String
    
    // Date formatter
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
    
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    var body: some View {
        
        if totalArray.count > 0 {
            
            VStack{
                HStack{
                    
                    if viewMode == "day" {
                        Text(totalArray[0].date, formatter: dateFormatter).bold()
                    } else if viewMode == "month" {
                        Text(totalArray[0].date, formatter: monthFormatter).bold()
                    }
                    
                    Spacer()
                }.font(.title2)
                
                // Create a list from the total expense array of the date
                List(totalArray.sorted(by: { $0.amount > $1.amount })){expense in
                    HStack {
                        VStack{
                            HStack{
                                Text(expense.title)
                                Spacer()
                                Text(String(expense.amount))
                            }
                            
                            HStack{
                                Text(expense.description ?? "").font(.caption)
                                Spacer()
                                Text(String(expense.category.rawValue))
                            }
                        }
                        
                        Image(systemName: "trash")
                            .onTapGesture {
                            // Remove from array
                            if let index = expensesViewModel.expenses.expenses.firstIndex(where: {expense.id == $0.id}) {
                                // Remove from CoreData
                                expensesViewModel.storage.removeExpense(expense: expensesViewModel.expenses.expenses[index])
                                
                                // Remove from array
                                expensesViewModel.expenses.expenses.remove(at: index)
                            }
                                
                            
                            // Return to the budget view
                            detailViewIsShown.toggle()
                        }
                        
                    }
                    
                    
                    
                }
            }.padding()
            
        } else {
            Text("No expense at this date")
        }
        
        
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(totalArray: .constant([]), detailViewIsShown: .constant(true), viewMode: .constant("day"))
    }
}
