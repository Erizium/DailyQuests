//
//  AddNextQuest.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-03-01.
//

import SwiftUI
import CoreData

struct AddNextQuest: View {
    
    @State private var typePicker = false
    @State private var selectedDaily = false
    @State private var selctedWeekly = false
    @State private var squareCheckedDaily = "square.dashed"
    @State private var squareCheckedWeekly = "square.dashed"
    @State private var newQuest = ""
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: TomorrowDaily.entity(), sortDescriptors: []) var tomorrowsDailys: FetchedResults<TomorrowDaily>
    @FetchRequest(entity: NextWeek.entity(), sortDescriptors: []) var nextWeek: FetchedResults<NextWeek>
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 100)
            Text("Add a new Quest").font(.largeTitle)
            Spacer().frame(height: 30)
            DisclosureGroup("Select Quest Type", isExpanded: $typePicker) {
                VStack {
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: squareCheckedDaily)
                        Spacer()
                        
                        Text("Tomorrow").onTapGesture {
                            squareCheckedDaily = squareCheckedDaily == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                            
                            if squareCheckedDaily == "square.dashed.inset.fill" {
                                squareCheckedWeekly = "square.dashed"
                            }
                        }
                        Spacer()
                    }
                    Spacer().frame(height: 10)
                    HStack {
                        Image(systemName: squareCheckedWeekly)
                        Spacer()
                        Text("Next Week").onTapGesture {
                            squareCheckedWeekly = squareCheckedWeekly == "square.dashed" ? "square.dashed.inset.fill" : "square.dashed"
                            if squareCheckedWeekly == "square.dashed.inset.fill" {
                                squareCheckedDaily = "square.dashed"
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
                        newTomorrowsQuest()
                    } else {
                        newNextWeekQuest()
                    }
                }){
                    Text("Add quest, next").font(.title3)
                }
                Spacer()
            }
            Spacer()
        }.padding()
    }
    
    private func newTomorrowsQuest() {
        let tomorrow = TomorrowDaily(context: self.viewContext)
        tomorrow.name = "\(newQuest)"
        
        try? self.viewContext.save()
        
        if self.viewContext.hasChanges {
            print("New quests for tomorrow has been added")
        }
        newQuest = ""
    }
    
    private func newNextWeekQuest() {
        let nextWeek = NextWeek(context: self.viewContext)
        nextWeek.name = "\(newQuest)"
        
        try? self.viewContext.save()
        
        if self.viewContext.hasChanges {
            print("New next weeks quests")
        }
        newQuest = ""
    }
}


struct AddNextQuest_Previews: PreviewProvider {
    static var previews: some View {
        AddNextQuest()
    }
}
