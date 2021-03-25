//
//  CategoryView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 20/03/2021.
//

import SwiftUI



struct CategoryView: View {
    
    @Binding var amountRatio: Float
    @Binding var color: Color
    @Binding var categoryName: String
    @Binding var amountCategory: Double
    @Binding var categoryImageName: String
    @Binding var currency: String
    
    var roundRadius: CGFloat = 60.0
    
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: roundRadius)
                    .frame(width: roundRadius, height: roundRadius)
                    .foregroundColor(color)
                Text(categoryImageName).font(.title)
            }
            
            
            VStack{
                HStack{
                    Text(categoryName)
                    Spacer()
                    Text("\(amountCategory, specifier: "%.2f")\(currency)")
                }
                
                ExpenseBarView(value: $amountRatio, categoryColor: $color).frame(height: 20)
            }
            
        }.padding()
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(amountRatio: .constant(0.7), color: .constant(.blue), categoryName: .constant("Home"), amountCategory: .constant(152.0), categoryImageName: .constant("🏠"), currency: .constant("£"))
            .previewLayout(.sizeThatFits)
    }
}
