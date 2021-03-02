//
//  YourWeeklyQuests.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

// göra så tomorrow quests ersätter dagens beroende på vilket datum de har.

import SwiftUI
import CoreData

struct YourWeeklyQuests: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Weekly.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Weekly.date, ascending: false)])
        var weeklys: FetchedResults<Weekly>
    @FetchRequest(entity: NextWeek.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NextWeek.date, ascending: false)])
        var nextWeek: FetchedResults<NextWeek>
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    @State private var addNewQuest = false
    @State private var addNextQuest = false
    @State private var completedWeeklyQuests = UserDefaults.standard.integer(forKey: "CompletedWeekly")
    
    @State private var timeRemaining = 24*60*60*7
    @State private var doneText = "Uncompleted"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Text("Weekly Quests").font(.largeTitle)
                    Image("QuestLetter")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                
                Spacer().frame(height: 50)
                DisclosureGroup("This weeks quests      \(completedWeeklyQuests)/\(weeklys.count)", isExpanded: $isExpanded) {
                    ScrollView {
                        VStack {
                            ForEach(weeklys) { weekly in
                                
                                HStack {
                                    Button(action: {
                                        weekly.done.toggle()
                                        
                                        if weekly.done == true {
                                            completedWeeklyQuests += 1
                                            print(completedWeeklyQuests)
                                        } else {
                                            completedWeeklyQuests -= 1
                                            print(completedWeeklyQuests)
                                        }
                                        UserDefaults.standard.set(completedWeeklyQuests, forKey: "CompletedWeekly")
                                        
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            print("Error weekly")
                                        }
                                    }) {
                                        Image(systemName: weekly.done == true ? "square.dashed.inset.fill" : "square.dashed")
                                    }
                                    Spacer()
                                    Text(weekly.name ?? "Unkown")
                                        .onTapGesture {
                                            viewContext.delete(weekly)
                                            
                                            try? viewContext.save()
                                        }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
                
                Button(action: {
                    self.addNewQuest = true
                }){
                    Text("Add quest")
                }.sheet(isPresented: $addNewQuest) {
                    AddQuest()
                }.padding()
                .offset(x: 250)
        
                Spacer().frame(height: 20)
                
                DisclosureGroup("Next Weeks Quests", isExpanded: $isExpanded2) {
                    ScrollView {
                        VStack {
                            ForEach(nextWeek) { nextWeek in
                                
                                HStack {
                                    Button(action: {
                                        nextWeek.done.toggle()
                                     
                                    }) {
                                        Image(systemName: nextWeek.done == true ? "square.dashed.inset.fill" : "square.dashed")
                                    }
                                    Spacer()
                                    Text(nextWeek.name ?? "Unkown")
                                        .onTapGesture {
                                            viewContext.delete(nextWeek)
                                            
                                            try? viewContext.save()
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
                
                Button(action: {
                    self.addNextQuest = true
                }){
                 Text("Add quest")
                }.sheet(isPresented: $addNextQuest) {
                    AddNextQuest()
                }.padding()
                .offset(x: 250)
                
            }.padding()
        }
    }
}

struct YourWeeklyQuests_Previews: PreviewProvider {
    static var previews: some View {
        YourWeeklyQuests()
    }
}
