//
//  ExpenseBarView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 21/03/2021.
//

import SwiftUI

struct ExpenseBarView: View {
    @Binding var value: Float
    @Binding var categoryColor: Color
    var cornerRadius: CGFloat = 45.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.1)
                    .foregroundColor(categoryColor)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(categoryColor)
                    .animation(.linear)
                    .cornerRadius(cornerRadius)
            }.cornerRadius(cornerRadius)
        }
    }
}

struct ExpenseBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseBarView(value: .constant(0.6), categoryColor: .constant(Color.green))
            .previewLayout(.sizeThatFits)
            .frame(height: 20)
    }
}
