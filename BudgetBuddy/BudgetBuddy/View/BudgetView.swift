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
    
    // Navigation to the detail view
    @State var detailViewIsShown = false
    
    init() {
        self.expensesViewModel = ExpensesViewModel()
    }
    
    var body: some View {
        
        VStack{
            
            DateView(chosenDate: $expensesViewModel.chosenDate.onChange(dateChanged))
            
            TotalExpenseView(amountTotal: $expensesViewModel.totalFileteredExpense, detailViewIsShown: $detailViewIsShown.onChange(changeExpense), totalArray: $expensesViewModel.filteredExpenses)
            
            ZStack{
                
                // Scroll view containing all categories
                ScrollView {
                    
                    ForEach((0..<expensesViewModel.categoryArray.count), id: \.self) {
                        
                        if expensesViewModel.categoryArray[$0].categoryExpense > 0.0 {
                            CategoryView(amountRatio: $expensesViewModel.categoryArray[$0].categoryRatio,
                                         color: $expensesViewModel.categoryArray[$0].categoryColor,
                                         categoryName: $expensesViewModel.categoryArray[$0].categoryName,
                                         amountCategory: $expensesViewModel.categoryArray[$0].categoryExpense,
                                         categoryImageName: $expensesViewModel.categoryArray[$0].categoryImageName)
                        }
                    }
                    
                }
                
                // VStack vith the addition button
                VStack{
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            expensesViewModel.filterExpenses()
                        }, label: {
                            Image(systemName: "arrow.clockwise.circle.fill").font(.largeTitle)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            additionViewIsShown.toggle()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 60)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "plus.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        })
                        .sheet(isPresented: $additionViewIsShown, content: {
                            AdditionView(additionViewIsShown: $additionViewIsShown.onChange(changeExpense))
                        })
                    }.padding()
                }
                
            }
            
            
        }
        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
            
        
        
    }
}