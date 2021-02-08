//
//  AddQuest.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct AddQuest: View {
    
    @State var newQuest: String = ""
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Daily.entity(), sortDescriptors: []) var dailys: FetchedResults<Daily>
    @FetchRequest(entity: Weekly.entity(), sortDescriptors: [])
        var weeklys: FetchedResults<Weekly>
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer().frame(height: 100)
            Text("Add a new Quest")
                .font(.largeTitle)
            
            
            Spacer().frame(height: 100)
            
            Form {
                Section {
            TextField("What's your new quest?", text: $newQuest)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                }
                
            }.frame(height: 125)
            .cornerRadius(7)
            Spacer()
            
            Button(action: {
                newDailyQuest()
                print("Add Daily pressed")
                newQuest = ""
            }) {
                Text("Add Daily")
            }.offset(x: 270, y: -150)
            
            Button(action: {
                newWeeklyQuest()
                print("Add Weekly pressed")
                newQuest = ""
            }){
                Text("Add Weekly")
            }.offset(x: 20, y: -170)
            
            Spacer()
            
        }.padding()
        
    }
    
    private func newDailyQuest() {
        
        let daily = Daily(context: self.viewContext)
        daily.name = "\(newQuest)"
        
        
        try? self.viewContext.save()
        
        if self.viewContext.hasChanges {
            print("New daily data available.")
        }
    }
    
    private func newWeeklyQuest() {
        let weekly = Weekly(context: self.viewContext)
        weekly.name = "\(newQuest)"
        
        try? self.viewContext.save()
        
        if self.viewContext.hasChanges {
            print("New weekly data available")
        }
    }
}

struct AddDailyQuest_Previews: PreviewProvider {
    static var previews: some View {
        AddQuest()
        
    }
}
