//
//  TotalExpenseView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 22/03/2021.
//

import SwiftUI

struct TotalExpenseView: View {
    
    @Binding var amountTotal: Double
    @Binding var detailViewIsShown: Bool
    @Binding var totalArray: [Expense]
    @Binding var currency: String
    @Binding var viewMode: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 120.0)
                .foregroundColor(.accentColor)
            
            HStack{
                Text("💰").font(.custom("", fixedSize: 80))
                Spacer()
                Text("\(amountTotal, specifier: "%.2f")\(currency)").font(.title)
            }.padding()
        }.padding()
        .onTapGesture {
            withAnimation {
                detailViewIsShown.toggle()
            }
        }
        .sheet(isPresented: $detailViewIsShown, content: {
            DetailView(totalArray: $totalArray, detailViewIsShown: $detailViewIsShown, viewMode: $viewMode)
        })
    }
}

struct TotalExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        TotalExpenseView(amountTotal: .constant(850.0), detailViewIsShown: .constant(true), totalArray: .constant([]), currency: .constant("$"), viewMode: .constant("day"))
            .previewLayout(.sizeThatFits)
    }
}
