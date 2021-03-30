//
//  BudgetBuddyExpenseAdditionWidget.swift
//  BudgetBuddyExpenseAdditionWidget
//
//  Created by Fabrice Ortega on 25/03/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), configuration: configuration)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct BudgetBuddyExpenseAdditionWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color("backgroundColor"))
            
            VStack{
                HStack{
                    Spacer()
                    Image("Pig")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .opacity(0.4)
                }
                Spacer()
            }
            
            
            
            
            VStack{
                HStack{
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.white)
                        Image("Buddy").resizable().scaleEffect(1.2)
                    }.frame(width: 20, height: 20)
                    
                    Spacer()
                    
                    
                    
                    
                }
                Spacer()
                Text("Add an expense")
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("textColor"))
                    .font(Font.custom("", size: 15))
                AdditionButtonView(cornerRadius: 60, fontSize: .largeTitle)
                    .foregroundColor(Color("buttonColor"))
                
                
                
                
//                AdditionButtonView(cornerRadius: 60)
//                    .foregroundColor(Color("buttonColor"))
                
                
                
                    
            }.padding()
        }.widgetURL(URL(string: "BudgetBuddy:///AdditionView"))
        
        
        
    }
}

@main
struct BudgetBuddyExpenseAdditionWidget: Widget {
    let kind: String = "BudgetBuddyExpenseAdditionWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            BudgetBuddyExpenseAdditionWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Expense addition Widget")
        .description("This will allow you to quickly add an expense.")
        .supportedFamilies([.systemSmall])
    }
}

struct BudgetBuddyExpenseAdditionWidget_Previews: PreviewProvider {
    static var previews: some View {
        BudgetBuddyExpenseAdditionWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
