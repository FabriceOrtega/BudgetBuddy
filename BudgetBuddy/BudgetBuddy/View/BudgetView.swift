//
//  BudgetView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 20/03/2021.
//

import SwiftUI

struct BudgetView: View {
    // Reference to the view model
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    // Navigation to the addition view
    @State var additionViewIsShown = false
    let additionViewUrl = URL(string: "BudgetBuddy:///AdditionView")
    
    
    // Navigation to the detail view
    @State var detailViewIsShown = false
    
    // Currency
    @AppStorage("currency") var currency = "€"
    
    // View mode
    @State var viewMode = "day"
    
    init() {
        self.expensesViewModel = ExpensesViewModel()
    }
    
    var body: some View {
        
        VStack{
            
            DateView(chosenDate: $expensesViewModel.chosenDate.onChange(dateChanged), currency: $currency, viewMode: $viewMode.onChange(changeViewMode))
            
            TotalExpenseView(amountTotal: $expensesViewModel.totalFileteredExpense, detailViewIsShown: $detailViewIsShown.onChange(changeExpense), totalArray: $expensesViewModel.filteredExpenses, currency: $currency, viewMode: $viewMode)
            
            ZStack{
                
                // Scroll view containing all categories
                ScrollView {
                    
                    ForEach((0..<expensesViewModel.categoryArray.count), id: \.self) {
                        
                        if expensesViewModel.categoryArray[$0].categoryExpense > 0.0 {
                            CategoryView(amountRatio: $expensesViewModel.categoryArray[$0].categoryRatio,
                                         color: $expensesViewModel.categoryArray[$0].categoryColor,
                                         categoryName: $expensesViewModel.categoryArray[$0].categoryName,
                                         amountCategory: $expensesViewModel.categoryArray[$0].categoryExpense,
                                         categoryImageName: $expensesViewModel.categoryArray[$0].categoryImageName,
                                         currency: $currency)
                        }
                    }
                    
                    // Clear rectangle to allow scrolling above the "add button"
                    Rectangle().frame(height: 60).foregroundColor(.clear)
                    
                }
                
                // VStack vith the addition button
                VStack{
                    Spacer()
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            additionViewIsShown.toggle()
                        }, label: {
                            AdditionButtonView(cornerRadius: 60, fontSize: .largeTitle)
                        })
                        .sheet(isPresented: $additionViewIsShown, content: {
                            AdditionView(additionViewIsShown: $additionViewIsShown.onChange(changeExpense))
                        })
                    }.padding()
                }
                
            }
            
            
        }
        .onOpenURL(perform: { url in
            // Open app directly on addition view when accesssing from the widget
            if url == additionViewUrl {
                additionViewIsShown = true
            }
        })
        
    }
    
    // Method to refresh the view when the date is changed
    func dateChanged(to value: Date){
        expensesViewModel.filterExpenses()
    }
    
    // Method to refresh the view when an expense is added or removed
    func changeExpense(to value: Bool){
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
            expensesViewModel.filterExpenses()
        }
    }
    
    // Method to refresh the view mode
    func changeViewMode(to value: String){
        if viewMode == "day" {
            expensesViewModel.displayMode = .day
        } else if viewMode == "month" {
            expensesViewModel.displayMode = .month
        }
        
        // Filter again after a small time
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
            expensesViewModel.filterExpenses()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
            
    }
}
