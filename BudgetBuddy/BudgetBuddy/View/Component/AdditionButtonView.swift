//
//  AdditionButtonView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 25/03/2021.
//

import SwiftUI

struct AdditionButtonView: View {
    var cornerRadius: CGFloat
    var fontSize: Font
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius/2)
                .frame(width: cornerRadius, height: cornerRadius)
            Image(systemName: "plus.circle")
                .font(fontSize)
                .foregroundColor(.white)
        }
    }
}

struct AdditionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionButtonView(cornerRadius: 60, fontSize: .largeTitle)
            .previewLayout(.sizeThatFits)
    }
}
