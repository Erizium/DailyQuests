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
    @State private var showAlert = false
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Daily.entity(), sortDescriptors: [
                    NSSortDescriptor(keyPath: \Daily.date, ascending:false)])
        var dailys: FetchedResults<Daily>
    @FetchRequest(entity: Weekly.entity(), sortDescriptors: [])
        var weeklys: FetchedResults<Weekly>
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer().frame(height: 100)
            HStack {
                Spacer()
            Text("Add a new Quest")
                .font(.largeTitle)
                
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .offset(x: 20)
                .foregroundColor(.blue)
                .onTapGesture {
                    print("hej")
                    showAlert = true
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Add new quest"), message: Text("\n1. Choose a quest type\n2. Type your quest in the text field.\n3. Click on 'Add quest'\n4. Quest has been added!\n5. Swipe down to go back."), dismissButton: .default(Text("Awesome")))
                }
                Spacer()
                
            }
            Spacer().frame(height: 30)
            DisclosureGroup("Select Quest Type", isExpanded: $questTypePicker) {
                VStack {
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: self.squareCheckedDaily)
                       
                        Spacer()
                        Text("Daily Quest")
                        Spacer()
                    }.onTapGesture {
                        
                        self.squareCheckedDaily = self.squareCheckedDaily == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                        if self.squareCheckedDaily == "square.dashed.inset.fill" {
                            self.squareCheckedWeekly = "square.dashed"
                        }
                    }
                    
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: self.squareCheckedWeekly)
                        Spacer()
                        Text("Weekly Quest")
                        Spacer()
                        }.onTapGesture {
                            self.squareCheckedWeekly = self.squareCheckedWeekly == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                            if self.squareCheckedWeekly == "square.dashed.inset.fill" {
                                self.squareCheckedDaily = "square.dashed"
                            }
                        
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
                    if newQuest != "" {
                        if squareCheckedDaily == "square.dashed.inset.fill" {
                            newDailyQuest()
                        } else {
                            newWeeklyQuest()
                        }
                        showAlert = true
                    }
                }) {
                    Text("Add quest").font(.title3)
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("New quest!"), message: Text("A new quest is available."), dismissButton: .default(Text("Nice")))
                }
                Spacer()
            }
            
            Spacer()
            
        }.padding()
        
    }
    
    private func newDailyQuest() {
        
        let daily = Daily(context: self.viewContext)
        daily.name = "\(newQuest)"
        daily.date = Date()
        
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
