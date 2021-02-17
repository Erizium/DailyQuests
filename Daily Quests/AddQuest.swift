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
    @State private var questTypePicker = false
    @State private var selectedDaily = false
    @State private var selctedWeekly = false
    @State private var squareCheckedDaily = "square.dashed"
    @State private var squareCheckedWeekly = "square.dashed"
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Daily.entity(), sortDescriptors: []) var dailys: FetchedResults<Daily>
    @FetchRequest(entity: Weekly.entity(), sortDescriptors: [])
        var weeklys: FetchedResults<Weekly>
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer().frame(height: 100)
            Text("Add a new Quest")
                .font(.largeTitle)
            Spacer().frame(height: 30)
            DisclosureGroup("Select Quest Type", isExpanded: $questTypePicker) {
                VStack {
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: self.squareCheckedDaily)
                       
                        Spacer()
                        Text("Daily Quest").onTapGesture {
                            
                            self.squareCheckedDaily = self.squareCheckedDaily == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                            if self.squareCheckedDaily == "square.dashed.inset.fill" {
                                self.squareCheckedWeekly = "square.dashed"
                            }
            
                        }
                        Spacer()
                    }
                    
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: self.squareCheckedWeekly)
                        Spacer()
                        Text("Weekly Quest").onTapGesture {
                            
                            self.squareCheckedWeekly = self.squareCheckedWeekly == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                            if self.squareCheckedWeekly == "square.dashed.inset.fill" {
                                self.squareCheckedDaily = "square.dashed"
                            }
                        }
                        Spacer()
                    }
                }.padding()
            }.padding()
            
            Spacer().frame(height: 20)
            
            Form {
                Section {
            TextField("What's your new quest?", text: $newQuest)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                }
                
            }.frame(height: 125)
            .cornerRadius(7)
            Spacer().frame(height: 50)
            HStack {
                Spacer()
                Button(action: {
                    if squareCheckedDaily == "square.dashed.inset.fill" {
                        newDailyQuest()
                    } else {
                        newWeeklyQuest()
                    }
                }) {
                    Text("Add quest").font(.title3)
                }
                Spacer()
            }
            
//            Button(action: {
//                newDailyQuest()
//                print("Add Daily pressed")
//                newQuest = ""
//            }) {
//                Text("Add Daily")
//            }.offset(x: 270, y: -150)
//
//            Button(action: {
//                newWeeklyQuest()
//                print("Add Weekly pressed")
//                newQuest = ""
//            }){
//                Text("Add Weekly")
//            }.offset(x: 20, y: -170)
//
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
        newQuest = ""
    }
    
    private func newWeeklyQuest() {
        let weekly = Weekly(context: self.viewContext)
        weekly.name = "\(newQuest)"
        
        try? self.viewContext.save()
        
        if self.viewContext.hasChanges {
            print("New weekly data available")
        }
        newQuest = ""
    }
}

struct AddDailyQuest_Previews: PreviewProvider {
    static var previews: some View {
        AddQuest()
        
    }
}
