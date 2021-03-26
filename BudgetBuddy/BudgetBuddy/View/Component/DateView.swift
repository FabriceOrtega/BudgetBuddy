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
    
    // Currency
    @Binding var currency: String
    let currencies = ["$", "€", "£", "¥"]
    
    // Day/Month view
    @Binding var viewMode: String
    let viewModes = ["day", "month"]
    
    // Bool to show the date picker
    @State var isChosingDate = false
    
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
        if !isChosingDate{
            VStack{
                
                
                HStack{
                    // Day/Month view picker
                    Picker("View mode : \(viewMode)", selection: $viewMode) {
                        ForEach(viewModes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                    
                    
                    Spacer()
                    
                    // Currency picker
                    Picker("Currency : \(currency)", selection: $currency) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                HStack{
                    if viewMode == "day" {
                        Text(chosenDate, formatter: dateFormatter).bold()
                    } else if viewMode == "month" {
                        Text(chosenDate, formatter: monthFormatter).bold()
                    }
                    
                    Image(systemName: "arrowtriangle.down.fill").font(.caption)
                    Spacer()
                    
                }
                .font(.title2)
                .onTapGesture {
                    withAnimation {
                        isChosingDate.toggle()
                    }
                }
            }.padding()
            
        }
        
        if isChosingDate{
            VStack{
                
                if viewMode == "day" {
                    DatePicker.init(selection: $chosenDate, displayedComponents: .date, label: {
                        EmptyView()
                    })
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    
                } else if viewMode == "month" {
                    DatePicker.init(selection: $chosenDate, displayedComponents: .date, label: {
                        EmptyView()
                    })
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    
                }
                
                
                //Button to validate
                Button(action: {
                    withAnimation {
                        isChosingDate.toggle()
                    }
                }, label: {
                    HStack{
                        Text("Hide")
                        Image(systemName: "arrowtriangle.up.fill").font(.caption)
                    }
                    
                })
            }
        }
        
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(chosenDate: .constant(Date()), currency: .constant("€"), viewMode: .constant("day"))
            .previewLayout(.sizeThatFits)
    }
}

