//
//  DateView.swift
//  BudgetBuddy
//
//  Created by Fabrice Ortega on 23/03/2021.
//

import SwiftUI

struct DateView: View {
    // Chosen date
    @Binding var chosenDate: Date
    
    // Bool to show the date picker
    @State var isChosingDate = false
    
    // Date formatter
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
    
    
    var body: some View {
        if !isChosingDate{
            HStack{
                Text(chosenDate, formatter: dateFormatter)
                    .font(.title2)
                    .bold()
                Image(systemName: "arrowtriangle.down.fill").font(.caption)
                Spacer()
                
            }.padding()
            .onTapGesture {
                withAnimation {
                    isChosingDate.toggle()
                }
                
            }
        }
        
        if isChosingDate{
            VStack{
                DatePicker.init(selection: $chosenDate, displayedComponents: .date, label: {
                    EmptyView()
                })
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                //Button to validate
                Button(action: {
                    withAnimation {
                        isChosingDate.toggle()
                    }
                }, label: {
                    Text("Hide")
                })
            }
        }
        
        
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(chosenDate: .constant(Date()))
    }
}

